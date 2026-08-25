import { dirname, join } from 'node:path';
import { defineConfig } from 'vite';
import { extensions, ember } from '@embroider/vite';
import { babel } from '@rollup/plugin-babel';
import { kolay } from 'kolay/vite';

const nebulixStyles = join(
  dirname(require.resolve('@1024pix/nebulix-ember/package.json')),
  'dist/styles',
);

export default defineConfig({
  plugins: [
    ember(),
    kolay(),
    babel({
      babelHelpers: 'runtime',
      extensions,
    }),
  ],
  css: {
    preprocessorOptions: {
      scss: {
        api: 'modern',
        loadPaths: [nebulixStyles],
      },
    },
  },
});
