import { defineConfig } from 'vite';
import { extensions, classicEmberSupport, ember } from '@embroider/vite';
import sassEmbedded from 'sass-embedded';
import { babel } from '@rollup/plugin-babel';

export default defineConfig({
   css: {
    preprocessorOptions: {
      scss: {
        api: 'modern',
        implementation: sassEmbedded,
        loadPaths: ['app/styles', 'node_modules/@1024pix/nebulix-ember/dist/styles'],
      },
    },
  },
  plugins: [
    classicEmberSupport(),
    ember(),
    // extra plugins here
    babel({
      babelHelpers: 'runtime',
      extensions,
    }),
  ],
});
