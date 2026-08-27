import Route from '@ember/routing/route';
import type Transition from '@ember/routing/transition';
import { handlePotentialIndexVisit } from 'kolay';

export default class RootIndexRoute extends Route {
  beforeModel(transition: Transition) {
    handlePotentialIndexVisit(this, transition);
  }
}
