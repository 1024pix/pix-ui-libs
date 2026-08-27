import './styles/app.scss';
import './styles/demo.scss';

import PageTitleService from 'ember-page-title/services/page-title';
import EmberApp from 'ember-strict-application-resolver';

import Router from './router.ts';

export default class App extends EmberApp {
  modules = {
    './router': Router,
    './services/page-title': PageTitleService,
    ...import.meta.glob('./routes/**/*', { eager: true }),
    ...import.meta.glob('./services/**/*', { eager: true }),
    ...import.meta.glob('./templates/**/*.{gjs,gts,js,ts,gjs.md,gts.md}', {
      eager: true,
    }),
  };
}
