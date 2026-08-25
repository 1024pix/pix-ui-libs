import { readFileSync } from 'node:fs';
import { dirname, extname, join } from 'node:path';
import { defineConfig } from 'vite';
import { extensions, ember } from '@embroider/vite';
import { babel } from '@rollup/plugin-babel';
import { kolay } from 'kolay/vite';

const nebulixRoot = dirname(
  require.resolve('@1024pix/nebulix-ember/package.json'),
);
const nebulixStyles = join(nebulixRoot, 'dist/styles');

const MIME_TYPES = {
  '.svg': 'image/svg+xml',
  '.woff2': 'font/woff2',
};

export default defineConfig({
  plugins: [
    ember(),
    kolay(),
    nebulixPublicAssets(),
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

/**
 * Nebulix declares its icon sprite and its fonts as addon public assets, served
 * at absolute URLs (`/@1024pix/nebulix-ember/…`)
 * Without this, the requests fall through to the SPA's index.html and fail
 * silently: icons render as empty `<svg>`, fonts fall back to system faces.
 */
function nebulixPublicAssets() {
  const manifest = JSON.parse(readFileSync(join(nebulixRoot, 'package.json'), 'utf8'));
  const assets = Object.entries(manifest['ember-addon']['public-assets']).map(
    ([source, url]) => {
      const mimeType = MIME_TYPES[extname(url)];
      if (!mimeType) {
        throw new Error(`Nebulix public asset "${url}" has has no MIME type. Add it to MIME_TYPES in docs-app/vite.config.mjs.`);
      }
      return { url, mimeType, path: join(nebulixRoot, source) };
    },
  );

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
        this.emitFile({ type: 'asset', fileName: url.replace(/^\//, ''), source: readFileSync(path) });
      }
    },
  };
}
