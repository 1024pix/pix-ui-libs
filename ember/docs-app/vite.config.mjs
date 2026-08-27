import { readFileSync } from 'node:fs';
import { dirname, extname, join } from 'node:path';

import { ember, extensions } from '@embroider/vite';
import { babel } from '@rollup/plugin-babel';
import { kolay } from 'kolay/vite';
import { defineConfig } from 'vite';

const nebulixRoot = dirname(require.resolve('@1024pix/nebulix-ember/package.json'));
const nebulixStyles = join(nebulixRoot, 'dist/styles');
const nebulixVersion = JSON.parse(readFileSync(join(nebulixRoot, 'package.json'), 'utf8')).version;

const MIME_TYPES = {
  '.svg': 'image/svg+xml',
  '.woff2': 'font/woff2',
};

export default defineConfig(({ mode }) => ({
  plugins: [
    ember(),
    kolay(),
    nebulixPublicAssets(),
    nebulixScopeStyles(),
    babel({
      babelHelpers: 'runtime',
      extensions,
    }),
  ],
  define: {
    __NEBULIX_VERSION__: JSON.stringify(nebulixVersion),
  },
  css: {
    preprocessorOptions: {
      scss: {
        api: 'modern',
        loadPaths: [nebulixStyles],
      },
    },
  },
  server: {
    host: '0.0.0.0',
  },
  // Code splitting is disabled to avoid too much chunks for the small Scalingo server.
  // Only in production: the test build has two inputs (index.html and
  // tests/index.html), which rolldown refuses to bundle without code splitting.
  build: { rolldownOptions: { output: { codeSplitting: mode !== 'production' } } },
}));

/**
 * Nebulix declares its icon sprite and its fonts as addon public assets, served
 * at absolute URLs (`/@1024pix/nebulix-ember/…`)
 * Without this, the requests fall through to the SPA's index.html and fail
 * silently: icons render as empty `<svg>`, fonts fall back to system faces.
 */
function nebulixPublicAssets() {
  const manifest = JSON.parse(readFileSync(join(nebulixRoot, 'package.json'), 'utf8'));
  const assets = Object.entries(manifest['ember-addon']['public-assets']).map(([source, url]) => {
    const mimeType = MIME_TYPES[extname(url)];
    if (!mimeType) {
      throw new Error(
        `Nebulix public asset "${url}" has has no MIME type. Add it to MIME_TYPES in docs-app/vite.config.mjs.`,
      );
    }
    return { url, mimeType, path: join(nebulixRoot, source) };
  });

  return {
    name: 'nebulix-public-assets',

    configureServer(server) {
      server.middlewares.use((request, response, next) => {
        const [pathname] = request.url.split('?');
        const asset = assets.find(({ url }) => url === pathname);

        if (!asset) return next();

        response.setHeader('Content-Type', asset.mimeType);
        response.end(readFileSync(asset.path));
      });
    },

    generateBundle() {
      for (const { url, path } of assets) {
        this.emitFile({
          type: 'asset',
          fileName: url.replace(/^\//, ''),
          source: readFileSync(path),
        });
      }
    },
  };
}

/**
 * Nebulix's stylesheet is written for a whole document: `:root` tokens, `html`
 * and `body` rules, bare element selectors. The docs app only wants it around
 * the live demos, so `demo.scss`'s compiled output is wrapped in
 * `@scope (.nebulix)` — the class `DemoFrame` renders.
 *
 * `:root` becomes `:scope`: inside the scope the root is the demo frame, not
 * the document element, so `:root` would match nothing and every design token
 * would be undefined.
 *
 * This plugin has no `enforce`, so its `transform` runs after Vite's own
 * `vite:css` (a core plugin, ordered before user plugins) and therefore sees
 * the compiled CSS rather than the Sass source.
 */
function nebulixScopeStyles() {
  const DEMO_STYLES = /\/app\/styles\/demo\.scss(\?|$)/;

  return {
    name: 'nebulix-scope-styles',

    transform(code, id) {
      if (!DEMO_STYLES.test(id)) return null;

      return {
        code: `@scope (.nebulix) {\n${code.replaceAll(':root', ':scope')}\n}\n`,
        map: null,
      };
    },
  };
}
