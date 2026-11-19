// Builds `dist/svg/pix-sprite.svg` from the icons of `./icons`.
//
// Icons come from the design team named `<name>-fill_false.svg` (outlined) and
// `<name>-fill_true.svg` (filled): they become the symbols `<name>` and
// `<name>_plain`, the ids `src/icons.js` points to.
import { mkdir, readdir, readFile, writeFile } from 'node:fs/promises';
import { basename, dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

import SVGSpriter from 'svg-sprite';
import { optimize } from 'svgo';

import svgoConfig from './svgo.config.js';

const toolingDir = dirname(fileURLToPath(import.meta.url));
const iconsDir = join(toolingDir, 'icons');
const output = join(toolingDir, '../../dist/svg/pix-sprite.svg');

function symbolId(file) {
  return basename(file, '.svg')
    .replace(/-fill_false$/, '')
    .replace(/-fill_true$/, '_plain');
}

const spriter = new SVGSpriter({
  log: false,
  shape: { id: { generator: symbolId } },
  mode: { defs: { inline: true, bust: false } },
});

const files = (await readdir(iconsDir)).filter((file) => file.endsWith('.svg')).sort();
for (const file of files) {
  const path = join(iconsDir, file);
  spriter.add(path, file, await readFile(path, 'utf8'));
}

const { result } = await spriter.compileAsync();
const { data } = optimize(result.defs.sprite.contents.toString(), svgoConfig);

await mkdir(dirname(output), { recursive: true });
await writeFile(output, data);
console.log(`${files.length} icons → ${output}`);
