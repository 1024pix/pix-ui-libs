import EmberRouter from '@embroider/router';
import { addRoutes } from 'kolay';

export default class Router extends EmberRouter {
  location = 'history';
  rootURL = '/';
}

Router.map(function () {
  // one top-level mount: every docs group is served from the root URL
  // space, with its group name as the first URL segment.
  addRoutes(this);
});
