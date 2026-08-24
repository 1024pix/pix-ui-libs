import { defineConfig } from 'vite';
import { extensions, classicEmberSupport, ember } from '@embroider/vite';
import sassEmbedded from 'sass-embedded';
import { babel } from '@rollup/plugin-babel';
import { docs, apiDocs } from "kolay/vite";

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
    // Your main docs in "this" app: a "my-documentation" group
    docs(import.meta.resolve("./my-documentation")),
    // Optional: generate API Docs for packages listed here
    apiDocs(["@1024pix/nebulix-ember"]),
    classicEmberSupport(),
    ember(),
    // extra plugins here
    babel({
      babelHelpers: 'runtime',
      extensions,
    }),
  ],
});
