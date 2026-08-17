import Route from '@ember/routing/route';
import { handlePotentialIndexVisit } from 'kolay';
import { setupKolay } from 'kolay/setup';

import type Transition from '@ember/routing/transition';

export default class Application extends Route {
  async model(): Promise<void> {
    await setupKolay(this, {
      modules: {
        '@1024pix/nebulix-ember': () => import('@1024pix/nebulix-ember'),
      },
    });
  }

  redirect(_model: void, transition: Transition): void {
    handlePotentialIndexVisit(this, transition);
  }
}
