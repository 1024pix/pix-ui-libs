import { fileURLToPath } from 'node:url';

import { defineConfig } from 'vite';
import { extensions, ember } from '@embroider/vite';
import { babel } from '@rollup/plugin-babel';
import { kolay } from 'kolay/vite';

// The group name becomes the URL prefix: pages live under /docs/*
const nebulixDocs = fileURLToPath(new URL('../nebulix/docs', import.meta.url));

const nebulixPackage = '@1024pix/nebulix-ember';

export default defineConfig({
  plugins: [
    ember(),
    kolay({
      groups: [{ name: 'docs', src: nebulixDocs }],
      packages: [nebulixPackage],
    }),
    babel({
      babelHelpers: 'runtime',
      extensions,
    }),
  ],
});
