import EmberApp from 'ember-strict-application-resolver';
import EmberRouter from '@ember/routing/router';
import PageTitleService from 'ember-page-title/services/page-title';
import PixToastService from '../src/services/pix-toast.js';

// --- Import default styles for Pix Nebulix components
import '../src/styles/normalize-reset/index.scss';
import '../src/styles/pix-design-tokens/index.scss';
import '../src/styles/_a11y.scss';
// ---

class Router extends EmberRouter {
  location = 'history';
  rootURL = '/';
}

export class App extends EmberApp {
  modules = {
    './router': Router,
    './services/page-title': PageTitleService,
    './services/pix-toast': PixToastService,
    ...import.meta.glob('./services/**/*', { eager: true }),
    ...import.meta.glob('./templates/**/*', { eager: true }),
  };
}

Router.map(function () {});
