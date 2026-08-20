import EmberRouter from '@embroider/router';
import config from 'test-app/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  // Route for the EmberJS route link tests
  this.route('hello', { path: '/hello-world' });
  this.route('bye', { path: '/bye/:id' });
});
