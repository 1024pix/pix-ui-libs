import { globSync, statSync } from 'node:fs';
import { readFile } from 'node:fs/promises';
import { join, relative, sep } from 'node:path';

/**
 * Sass shipped to consumers as-is: apps compile it themselves with
 * `loadPaths: ['…/@1024pix/nebulix-vue/dist/styles']` (the `nebulix()` Vite
 * plugin of `@1024pix/nebulix-vue/vite` sets it up). `styles/nebulix-styles.scss`
 * reaches `../components`, so both trees keep their relative position.
 */
const PUBLISHED_PATTERNS = ['components/**/*.scss', 'styles/**/*.scss'];

const SPRITE = 'svg/pix-sprite.svg';
const FONTS_MODULE = 'styles/pix-design-tokens/_fonts.scss';
const DEFAULT_ASSETS_URL = /\$nebulix-assets-url: '[^']*' !default;/;

/**
 * @param {string[]} dirs
 * @param {string[]} patterns
 * @returns {{ file: string, path: string }[]} Matching files, with their path
 *   relative to their directory, POSIX-style.
 */
function filesOf(dirs, patterns) {
  return dirs.flatMap((dir) =>
    patterns
      .flatMap((pattern) => globSync(join(dir, pattern)))
      .filter((file) => statSync(file).isFile())
      .map((file) => ({ file, path: relative(dir, file).split(sep).join('/') })),
  );
}

/**
 * Embeds what the library needs from `@1024pix/nebulix-styles`, an internal
 * package that is never published.
 *
 * - The Sass is copied into `dist/`, with the default of `$nebulix-assets-url`
 *   rewritten to `assetsUrl`, where this package serves its fonts.
 * - The fonts and the icon sprite (`assets/`) are copied into `dist/public/`.
 *
 * The icon map needs nothing here: `src/helpers/icons.ts` imports it and Vite
 * bundles it, `vue` being the only external dependency.
 *
 * @param {{ stylesRoot: string, assetsUrl: string }} options
 * @returns {import('vite').Plugin}
 */
export function nebulixStyles({ stylesRoot, assetsUrl }) {
  const sources = () => filesOf([join(stylesRoot, 'src')], PUBLISHED_PATTERNS);
  const assets = () =>
    filesOf([join(stylesRoot, 'assets')], ['**/*']).sort((a, b) => a.path.localeCompare(b.path));

  return {
    name: 'nebulix-styles',
    apply: 'build',

    buildStart() {
      for (const { file } of [...sources(), ...assets()]) {
        this.addWatchFile(file);
      }
    },

    async generateBundle() {
      const sourceFiles = sources();
      if (sourceFiles.length === 0) {
        this.error(`No Sass source found in "${stylesRoot}/src". Check PUBLISHED_PATTERNS.`);
      }

      const assetFiles = assets();
      if (!assetFiles.some(({ path }) => path === SPRITE)) {
        this.error(`No icon sprite found in "${stylesRoot}/assets".`);
      }

      await Promise.all([
        ...sourceFiles.map(async ({ file, path }) => {
          let source = await readFile(file, 'utf8');

          if (path === FONTS_MODULE) {
            if (!DEFAULT_ASSETS_URL.test(source)) {
              this.error(`No \`$nebulix-assets-url\` default found in ${FONTS_MODULE}.`);
            }
            source = source.replace(
              DEFAULT_ASSETS_URL,
              `$nebulix-assets-url: '${assetsUrl}' !default;`,
            );
          }

          this.emitFile({ type: 'asset', fileName: path, source });
        }),
        ...assetFiles.map(async ({ file, path }) =>
          this.emitFile({
            type: 'asset',
            fileName: `public/${path}`,
            source: await readFile(file),
          }),
        ),
      ]);
    },
  };
}
