import Route from '@ember/routing/route';
import type RouterService from '@ember/routing/router-service';
import type Transition from '@ember/routing/transition';
import { service } from '@ember/service';
import { handlePotentialIndexVisit } from 'kolay';

export default class PageRoute extends Route {
  @service declare router: RouterService;

  /**
   * Every doc page goes through this one route (only its `path` param
   * changes), so the `<main>` scroll container is never re-rendered and
   * keeps its scroll position from one page to the next. Kolay does not
   * handle it: reset it ourselves whenever the page itself changes.
   */
  #lastPath?: string;

  constructor(...args: ConstructorParameters<typeof Route>) {
    super(...args);
    this.router.on('routeDidChange', this.#resetScroll);
  }

  willDestroy(): void {
    this.router.off('routeDidChange', this.#resetScroll);
    super.willDestroy();
  }

  beforeModel(transition: Transition) {
    handlePotentialIndexVisit(this, transition);
  }

  #resetScroll = (): void => {
    const path = window.location.pathname;
    const previousPath = this.#lastPath;
    this.#lastPath = path;
    // First load: leave the browser's own positioning (e.g. a `#anchor`) alone.
    if (previousPath === undefined || path === previousPath) return;

    // Wide screens scroll `<main>`; narrow ones scroll the window.
    document.querySelector('.app-layout > main')?.scrollTo(0, 0);
    window.scrollTo(0, 0);
  };
}
