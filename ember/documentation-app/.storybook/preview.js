import Application from 'documentation-app/app';
import config from 'documentation-app/config/environment';
import { setApplication } from '@ember/test-helpers';

// Bootstrap the Ember runtime so stories can render Glimmer components.
// autoboot: false prevents the app from mounting to the page itself —
// each story handles its own rendering via @ember/test-helpers.
setApplication(Application.create({ ...config.APP, autoboot: false }));

/** @type { import('@storybook/html').Preview } */
const preview = {
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/i,
      },
    },
  },
};

export default preview;