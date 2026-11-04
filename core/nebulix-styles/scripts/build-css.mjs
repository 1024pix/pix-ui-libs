/**
 * Compiles the Sass sources into ready-to-use stylesheets for consumers that
 * do not run Sass themselves (e.g. a Vue app importing `nebulix.css`).
 *
 * Fonts are referenced relatively to `dist/` (`../assets/fonts/…`), so a
 * bundler importing the CSS resolves and emits them on its own. Consumers of
 * the raw Sass keep the absolute default of `$nebulix-assets-url` instead.
 */
import { mkdir, watch, writeFile } from 'node:fs/promises';
import { dirname, join } from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';

import { compileStringAsync } from 'sass-embedded';

const root = join(dirname(fileURLToPath(import.meta.url)), '..');
const stylesDir = join(root, 'src/styles');
const distDir = join(root, 'dist');

const ENTRIES = {
  'nebulix.css': 'nebulix-styles',
  'tokens.css': 'tokens',
};

async function build() {
  await mkdir(distDir, { recursive: true });

  for (const [output, entry] of Object.entries(ENTRIES)) {
    const outputPath = join(distDir, output);
    // `config` has to be configured before anything else loads it.
    const source = `@use 'config' with ($nebulix-assets-url: '../assets');\n@use '${entry}';\n`;

    const { css } = await compileStringAsync(source, {
      loadPaths: [stylesDir],
      // Lets the entry resolve `config` to the same canonical URL as the
      // partials do, so the configuration above actually applies to them.
      url: pathToFileURL(join(stylesDir, `__${entry}-entry.scss`)),
      style: 'expanded',
    });

    await writeFile(outputPath, `${css}\n`);
    console.log(`built dist/${output}`);
  }
}

await build();

if (process.argv.includes('--watch')) {
  console.log('watching src/ for changes…');
  let pending;
  for await (const _event of watch(join(root, 'src'), { recursive: true })) {
    clearTimeout(pending);
    pending = setTimeout(() => build().catch((error) => console.error(error.message)), 100);
  }
}
