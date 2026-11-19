import { existsSync, globSync, readFileSync, statSync } from 'node:fs';
import { dirname, extname, join, relative, resolve, sep } from 'node:path';
import { fileURLToPath } from 'node:url';

/** URL under which the fonts and the icon sprite are served by default. */
export const ASSETS_URL = '/@1024pix/nebulix-vue';

const packageRoot = dirname(fileURLToPath(import.meta.url));
const publicDir = join(packageRoot, 'dist/public');
const stylesDir = join(packageRoot, 'dist/styles');

const MIME_TYPES = {
  '.svg': 'image/svg+xml',
  '.woff2': 'font/woff2',
};

/**
 * Vite plugin for apps using `@1024pix/nebulix-vue`:
 *
 * - adds Nebulix's Sass to `loadPaths`, so that `@use 'nebulix-styles';` works;
 * - serves the fonts and the icon sprite under `/@1024pix/nebulix-vue/…` in
 *   dev, and emits them at the same place in the build output.
 *
 * Without the latter, the requests fall through to the SPA's index.html and
 * fail silently: icons render as empty `<svg>`, fonts fall back to system faces.
 *
 * @returns {import('vite').Plugin}
 */
export function nebulix() {
  return {
    name: '@1024pix/nebulix-vue',

    config() {
      return {
        css: { preprocessorOptions: { scss: { loadPaths: [stylesDir] } } },
      };
    },

    configureServer(server) {
      server.middlewares.use((request, response, next) => {
        const [pathname] = (request.url ?? '').split('?');
        if (!pathname.startsWith(`${ASSETS_URL}/`)) return next();

        const file = resolve(publicDir, `.${pathname.slice(ASSETS_URL.length)}`);
        const mimeType = MIME_TYPES[extname(file)];
        if (!file.startsWith(publicDir + sep) || !mimeType || !existsSync(file)) return next();

        response.setHeader('Content-Type', mimeType);
        response.end(readFileSync(file));
      });
    },

    generateBundle() {
      for (const file of globSync(join(publicDir, '**/*'))) {
        if (!statSync(file).isFile()) continue;

        this.emitFile({
          type: 'asset',
          fileName: `${ASSETS_URL.slice(1)}/${relative(publicDir, file).split(sep).join('/')}`,
          source: readFileSync(file),
        });
      }
    },
  };
}
