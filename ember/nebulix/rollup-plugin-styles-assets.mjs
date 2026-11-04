import { globSync, statSync } from 'node:fs';
import { readFile, writeFile } from 'node:fs/promises';
import { join, relative, resolve, sep } from 'node:path';

const PUBLIC_DIR = 'public';

/**
 * @param {string} assetsDir
 * @returns {string[]} Paths of every file in `assetsDir`, sorted.
 */
function assetFiles(assetsDir) {
  return globSync(join(assetsDir, '**/*'))
    .filter((file) => statSync(file).isFile())
    .sort();
}

/**
 * Embeds what the addon needs from `@1024pix/nebulix-styles`, an internal
 * package that is never published.
 *
 * - The fonts and the icon sprite are emitted straight into `dist/public/` and
 *   declared in `package.json#ember-addon.public-assets` (what
 *   `addon.publicAssets()` would do, but without an intermediate copy on disk):
 *   Embroider only serves public assets that live inside the addon package.
 *   They are served under `/<namespace>/…`.
 * - `iconsModule` (the addon's `helpers/icons.js`) is replaced by the content
 *   of `@1024pix/nebulix-styles/icons`, so the published code does not import
 *   the internal package.
 *
 * @param {{ assetsDir: string, namespace: string, iconsSource: string, iconsModule: string }} options
 * @returns {import('rollup').Plugin}
 */
export function stylesAssets({ assetsDir, namespace, iconsSource, iconsModule }) {
  const iconsModulePath = resolve(iconsModule);

  return {
    name: 'nebulix-styles-assets',

    buildStart() {
      this.addWatchFile(iconsSource);
      for (const file of assetFiles(assetsDir)) {
        this.addWatchFile(file);
      }
    },

    async load(id) {
      if (id !== iconsModulePath) return null;
      return readFile(iconsSource, 'utf8');
    },

    async generateBundle(options) {
      const files = assetFiles(assetsDir);

      if (files.length === 0) {
        this.error(`No asset found in "${assetsDir}".`);
      }

      const destDir = relative(process.cwd(), options.dir).split(sep).join('/');
      const publicAssets = {};

      await Promise.all(
        files.map(async (file) => {
          const path = relative(assetsDir, file).split(sep).join('/');
          this.emitFile({
            type: 'asset',
            fileName: `${PUBLIC_DIR}/${path}`,
            source: await readFile(file),
          });
          publicAssets[`./${destDir}/${PUBLIC_DIR}/${path}`] = `/${namespace}/${path}`;
        }),
      );

      await writePublicAssets(Object.fromEntries(Object.entries(publicAssets).sort()));
    },
  };
}

/**
 * Writes the map into the addon's package.json, only when it changed so that
 * `rollup --watch` does not loop and the file is not needlessly touched.
 *
 * @param {Record<string, string>} publicAssets
 */
async function writePublicAssets(publicAssets) {
  const pkgPath = resolve('package.json');
  const pkg = JSON.parse(await readFile(pkgPath, 'utf8'));

  if (JSON.stringify(pkg['ember-addon']['public-assets']) === JSON.stringify(publicAssets)) {
    return;
  }

  pkg['ember-addon']['public-assets'] = publicAssets;
  await writeFile(pkgPath, `${JSON.stringify(pkg, null, 2)}\n`);
}
