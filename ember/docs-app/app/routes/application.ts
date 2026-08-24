import Route from '@ember/routing/route';
import { setupKolay } from 'kolay/setup';
import type Transition from '@ember/routing/transition';

import { handlePotentialIndexVisit } from 'kolay';
import type { Manifest } from 'kolay';

export default class ApplicationRoute extends Route {
  async model(): Promise<{ manifest: Manifest }> {
    const manifest = await setupKolay(this);

    return { manifest };
  }

  redirect(_model: void, transition: Transition): void {
    handlePotentialIndexVisit(this, transition);
  }
}
