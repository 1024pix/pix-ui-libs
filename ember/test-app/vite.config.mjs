import { createRequire } from 'node:module';
import { dirname, join } from 'node:path';
import { defineConfig } from 'vite';
import { extensions, classicEmberSupport, ember } from '@embroider/vite';
import { babel } from '@rollup/plugin-babel';

const require = createRequire(import.meta.url);

/**
 * Nebulix ships raw Sass, so the app compiles it. Its partials cross-reference
 * each other through bare specifiers (`@use 'pix-design-tokens/typography'`),
 * which only resolve when this directory is on Sass's load path.
 *
 * Resolved through Node rather than hardcoded so it survives hoisting.
 */
const nebulixStyles = join(
  dirname(require.resolve('@1024pix/nebulix-ember/package.json')),
  'dist/styles',
);

export default defineConfig({
  plugins: [
    classicEmberSupport(),
    ember(),
    // extra plugins here
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
