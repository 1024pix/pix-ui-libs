import { defineConfig } from 'vite';
import { extensions, ember } from '@embroider/vite';
import { babel } from '@rollup/plugin-babel';
import { kolay } from 'kolay/vite';

export default defineConfig({
  plugins: [
    ember(),
    kolay(),
    babel({
      babelHelpers: 'runtime',
      extensions,
    }),
  ],
});
