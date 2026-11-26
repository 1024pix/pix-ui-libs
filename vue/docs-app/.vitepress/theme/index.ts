import './custom.css';
import './demo.scss';

import type { Theme } from 'vitepress';
import DefaultTheme from 'vitepress/theme';

import ApiTable from './components/ApiTable.vue';
import DemoFrame from './components/DemoFrame.vue';

export default {
  extends: DefaultTheme,
  enhanceApp({ app }) {
    app.component('ApiTable', ApiTable);
    app.component('DemoFrame', DemoFrame);
  },
} satisfies Theme;
