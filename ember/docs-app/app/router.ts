import EmberRouter from '@embroider/router';
import { addRoutes } from 'kolay';

export default class Router extends EmberRouter {
  location = 'history';
  rootURL = '/';
}

Router.map(function () {
  addRoutes(this);
});
