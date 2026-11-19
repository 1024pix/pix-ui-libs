import { createRequire } from 'node:module';
import { dirname } from 'node:path';

import vue from '@vitejs/plugin-vue';
import { defineConfig } from 'vite';

import { ASSETS_URL } from './vite.js';
import { nebulixStyles } from './vite-plugin-nebulix-styles.mjs';

const require = createRequire(import.meta.url);
const stylesRoot = dirname(require.resolve('@1024pix/nebulix-styles/package.json'));

export default defineConfig({
  plugins: [vue(), nebulixStyles({ stylesRoot, assetsUrl: ASSETS_URL })],
  build: {
    lib: {
      entry: 'src/index.ts',
      formats: ['es'],
      fileName: 'index',
    },
    rolldownOptions: {
      external: ['vue'],
    },
    sourcemap: true,
    copyPublicDir: false,
  },
});
