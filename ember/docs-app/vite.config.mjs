import { defineConfig } from 'vite';
import { extensions, ember } from '@embroider/vite';
import { babel } from '@rollup/plugin-babel';
import { kolay } from 'kolay/vite';

export default defineConfig({
  plugins: [
    ember(),
    kolay(),
    // docs('UI', { src: import.meta.resolve('../ui/ui-guide', import.meta.url) }),
    babel({
      babelHelpers: 'runtime',
      extensions,
    }),
  ],
});
