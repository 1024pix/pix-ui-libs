import EmberRouter from '@embroider/router';
import { properLinks } from 'ember-primitives/proper-links';
import { addRoutes } from 'kolay';

// kolay's navigation (PageNav, Search…) renders plain `<a href>`: properLinks
// routes in-app clicks through the Ember router instead of reloading the page.
@properLinks
export default class Router extends EmberRouter {
  location = 'history';
  rootURL = '/';
}

Router.map(function () {
  addRoutes(this);
});
