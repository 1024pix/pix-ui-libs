import { globSync } from 'node:fs';
import { readFile } from 'node:fs/promises';
import { join, relative } from 'node:path';

/**
 * Files shipped to consumers as-is, as decided in the addon's public API.
 *
 * Consumers compile the Sass themselves, so `dist/` must be self-sufficient:
 * every `@use` target referenced from these patterns has to be published too,
 * at the same relative position it has in `src/`.
 *
 * Fonts are not here: Vite does not rebase relative `url()` in Sass reached
 * through `loadPaths`, so they ship as public assets under an absolute URL.
 *
 * Deliberately excluded: `styles/_pix-*.scss` and `styles/addon.scss` (the
 * pix-ui dump kept as a migration staging area) and `styles/component-state/`
 * (only reachable from that dump).
 */
const PUBLISHED_PATTERNS = [
  'components/**/*.scss',
  'styles/normalize-reset/**/*.scss',
  'styles/pix-design-tokens/**/*.scss',
  'styles/_base.scss',
  'styles/_a11y.scss',
  'styles/_trap-focus.scss',
  'styles/nebulix-styles.scss',
];

/**
 * @param {string} srcDir
 * @returns {string[]} Paths of every file meant for consumers.
 */
function publishedFiles(srcDir) {
  return PUBLISHED_PATTERNS.flatMap((pattern) => globSync(join(srcDir, pattern)));
}

/**
 * Copies the published sources verbatim from `srcDir` into the rollup output
 * directory, preserving their relative paths.
 *
 * `publicEntrypoints` cannot be used for this: rollup treats the listed files
 * as JavaScript entry points and replaces them with JS stubs that keep the
 * original extension, which corrupts every file it touches.
 *
 * @param {{ srcDir?: string }} [options]
 * @returns {import('rollup').Plugin}
 */
export function publishedSources({ srcDir = 'src' } = {}) {
  return {
    name: 'nebulix-published-sources',

    buildStart() {
      // Without this, editing a partial during `rollup --watch` triggers no
      // rebuild and the copy in dist/ silently goes stale.
      for (const file of publishedFiles(srcDir)) {
        this.addWatchFile(file);
      }
    },

    async generateBundle(_options, bundle) {
      const files = publishedFiles(srcDir);

      if (files.length === 0) {
        this.error(`No published source matched in "${srcDir}". Check PUBLISHED_PATTERNS.`);
      }

      // Sass imported from JavaScript is already emitted by `keepAssets`;
      // only the files reachable through `@use` or `url()` alone are missing.
      const missing = files.filter((file) => !Object.hasOwn(bundle, relative(srcDir, file)));

      await Promise.all(
        missing.map(async (file) =>
          this.emitFile({
            type: 'asset',
            fileName: relative(srcDir, file),
            // Read as a Buffer so font binaries survive the copy intact.
            source: await readFile(file),
          }),
        ),
      );
    },
  };
}
