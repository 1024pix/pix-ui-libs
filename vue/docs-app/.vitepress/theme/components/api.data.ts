import { globSync } from 'node:fs';
import { createRequire } from 'node:module';
import { basename, dirname, join } from 'node:path';

import { createChecker } from 'vue-component-meta';

export interface PropDoc {
  name: string;
  type: string;
  required: boolean;
  default?: string;
  description: string;
}

export type ApiData = Record<string, { props: PropDoc[] }>;

const require = createRequire(import.meta.url);
const nebulixRoot = dirname(require.resolve('@1024pix/nebulix-vue/package.json'));
const COMPONENTS = 'src/components/**/*.vue';

declare const data: ApiData;
export { data };

/**
 * VitePress data loader: reads the props of every Nebulix component — types,
 * defaults and JSDoc — from its sources, at build time (and on change in dev).
 * See https://vitepress.dev/guide/data-loading
 */
export default {
  watch: [join(nebulixRoot, COMPONENTS)],

  load(): ApiData {
    const checker = createChecker(join(nebulixRoot, 'tsconfig.json'), {
      forceUseTs: true,
      printer: { newLine: 1 },
    });

    return Object.fromEntries(
      globSync(join(nebulixRoot, COMPONENTS))
        .filter((file) => !file.includes('/demos/'))
        .map((file) => {
          const props = checker
            .getComponentMeta(file)
            .props.filter((prop) => !prop.global)
            .map((prop) => ({
              name: prop.name,
              type: prop.type.replace(/ \| undefined$/, ''),
              required: prop.required,
              // `withDefaults` declares explicit `undefined` defaults for optional props.
              default: prop.default === 'undefined' ? undefined : prop.default,
              description: prop.description,
            }));

          return [basename(file, '.vue'), { props }];
        }),
    );
  },
};
