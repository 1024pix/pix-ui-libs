import EmberRouter from '@embroider/router';
import config from 'docs/config/environment';
import { addDocfyRoutes } from '@docfy/ember';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  // Add route declarations here
  addDocfyRoutes(this)
});
