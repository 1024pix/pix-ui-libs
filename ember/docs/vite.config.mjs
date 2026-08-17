import { defineConfig } from 'vite';
import { extensions, classicEmberSupport, ember } from '@embroider/vite';
import { babel } from '@rollup/plugin-babel';
import docfy from '@docfy/ember-vite';


export default defineConfig({
  plugins: [
    classicEmberSupport(),
    ember(),
    // extra plugins here
    babel({
      babelHelpers: 'runtime',
      extensions,
    }),
    docfy(
      /** @type {import('@docfy/ember-vite').DocfyViteOptions} */
      {
        root: process.cwd(),
        hmr: true,
        config: {
          sources: [
            {
              root: '.',
              pattern: '**/*.md',
              urlPrefix: 'docs',
            },
          ],
        },
      }
    )
  ],
});
