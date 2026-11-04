import { cp, readFile, rm } from 'node:fs/promises';
import { resolve } from 'node:path';

/**
 * Embeds what the addon needs from `@1024pix/nebulix-styles`, an internal
 * package that is never published.
 *
 * - The fonts and the icon sprite are copied into `to` before
 *   `addon.publicAssets()` runs: Embroider only serves public assets that live
 *   inside the addon package. The copy is gitignored and shipped in the tarball
 *   (see `files` in package.json).
 * - `iconsModule` (the addon's `helpers/icons.js`) is replaced by the content
 *   of `@1024pix/nebulix-styles/icons`, so the published code does not import
 *   the internal package.
 *
 * @param {{ assetsDir: string, to: string, iconsSource: string, iconsModule: string }} options
 * @returns {import('rollup').Plugin}
 */
export function stylesAssets({ assetsDir, to, iconsSource, iconsModule }) {
  const iconsModulePath = resolve(iconsModule);

  return {
    name: 'nebulix-styles-assets',

    async buildStart() {
      this.addWatchFile(iconsSource);
      await rm(to, { recursive: true, force: true });
      await cp(assetsDir, to, { recursive: true });
    },

    async load(id) {
      if (id !== iconsModulePath) return null;
      return readFile(iconsSource, 'utf8');
    },
  };
}
