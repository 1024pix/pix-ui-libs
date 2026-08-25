import { createRequire } from 'node:module';
import { dirname, join } from 'node:path';

const require = createRequire(import.meta.url);

const nebulixStyles = join(
  dirname(require.resolve('@1024pix/nebulix-ember/package.json')),
  'dist/styles',
);

/** @type { import('@storybook/html-vite').StorybookConfig } */
const config = {
  stories: ['../stories/**/*.mdx', '../stories/**/*.stories.{js,gjs}'],

  framework: {
    name: '@storybook/html-vite',
    options: {},
  },

  addons: ['@storybook/addon-essentials'],

  async viteFinal(storybookConfig) {
    const { mergeConfig } = await import('vite');
    const { classicEmberSupport, ember, extensions } = await import('@embroider/vite');
    const { babel } = await import('@rollup/plugin-babel');

    return mergeConfig(storybookConfig, {
      plugins: [
        classicEmberSupport(),
        ember(),
        babel({ babelHelpers: 'runtime', extensions }),
      ],
      css: {
        preprocessorOptions: {
          scss: {
            api: 'modern',
            loadPaths: [nebulixStyles],
          },
        },
      },
    });
  },
};

export default config;