import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { handlePotentialIndexVisit } from 'kolay';
import { setupKolay } from 'kolay/setup';

import type RouterService from '@ember/routing/router-service';
import type Transition from '@ember/routing/transition';
import type { Manifest } from 'kolay';

export default class ApplicationRoute extends Route {
  @service declare router: RouterService;

  async model(): Promise<{ manifest: Manifest }> {
    const manifest = await setupKolay(this, {
      modules: {
        '@1024pix/nebulix-ember': () => import('@1024pix/nebulix-ember'),
      },
    });
    return { manifest };
  }

  redirect(_model: void, transition: Transition): void {
    handlePotentialIndexVisit(this, transition);
  }
}
