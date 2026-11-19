import { createRequire } from 'node:module';
import { dirname, join } from 'node:path';

import { nebulix } from '@1024pix/nebulix-vue/vite';
import { defineConfig, type UserConfig } from 'vitepress';

type VitePlugin = NonNullable<NonNullable<UserConfig['vite']>['plugins']>[number];

const require = createRequire(import.meta.url);
const nebulixRoot = dirname(require.resolve('@1024pix/nebulix-vue/package.json'));

/**
 * Nebulix's stylesheet is written for a whole document: `:root` tokens, `html`
 * and `body` rules, bare element selectors. The docs only want it around the
 * live demos, so `theme/demo.scss`'s compiled output is wrapped in
 * `@scope (.nebulix)` — the class `DemoFrame` renders — and `:root` becomes
 * `:scope`, otherwise every design token would be undefined inside the scope.
 *
 * No `enforce`: this runs after Vite's own `vite:css`, on the compiled CSS.
 */
function nebulixScopeStyles() {
  const DEMO_STYLES = /\/\.vitepress\/theme\/demo\.scss(\?|$)/;

  return {
    name: 'nebulix-scope-styles',
    transform(code: string, id: string) {
      if (!DEMO_STYLES.test(id)) return null;
      return {
        code: `@scope (.nebulix) {\n${code.replaceAll(':root', ':scope')}\n}\n`,
        map: null,
      };
    },
  };
}

// The pages live next to what they document, in the library: its guides in
// `docs/`, and each component's page beside its `.vue` file.
export default defineConfig({
  lang: 'fr-FR',
  title: 'Nebulix Vue',
  description: 'Design system de Pix pour les applications Vue',
  srcDir: nebulixRoot,
  srcExclude: ['README.md', 'CHANGELOG.md', 'dist/**', 'declarations/**'],
  rewrites: {
    'docs/index.md': 'index.md',
    'docs/:path(.*)': 'nebulix/:path',
    'src/components/:path(.*)': 'components/:path',
  },
  cleanUrls: true,
  lastUpdated: false,
  markdown: {
    theme: { light: 'github-light', dark: 'github-dark' },
  },
  themeConfig: {
    nav: [
      { text: 'Nebulix', link: '/nebulix/nebulix-vue/installation' },
      { text: 'Composants', link: '/components/actions/pix-button' },
    ],
    sidebar: {
      '/nebulix/': [
        {
          text: 'Nebulix Vue',
          items: [{ text: 'Installation', link: '/nebulix/nebulix-vue/installation' }],
        },
      ],
      '/components/': [
        {
          text: 'Actions',
          items: [{ text: 'PixButton', link: '/components/actions/pix-button' }],
        },
      ],
    },
    search: { provider: 'local' },
    outline: { label: 'Sur cette page' },
    docFooter: { prev: 'Page précédente', next: 'Page suivante' },
    socialLinks: [{ icon: 'github', link: 'https://github.com/1024pix/pix-ui-libs' }],
  },
  vite: {
    // Vite's root is `srcDir`, the library: without this, Vite would also load
    // the library's own `vite.config.ts` (its build), and compile `.vue` twice.
    configFile: false,
    plugins: [
      // In this workspace, `@1024pix/nebulix-vue/vite` is typed against the
      // library's Vite (8), while VitePress 1 runs Vite 5: the plugin works with
      // both, only their type declarations differ.
      nebulix() as unknown as VitePlugin,
      nebulixScopeStyles(),
    ],
    resolve: {
      // Pages and demos live in the library, which does not depend on itself:
      // point its name at its build output, as an app would get it.
      alias: [{ find: /^@1024pix\/nebulix-vue$/, replacement: join(nebulixRoot, 'dist/index.js') }],
      dedupe: ['vue'],
    },
    css: {
      // VitePress ships Vite 5, where `loadPaths` needs the modern Sass API.
      preprocessorOptions: { scss: { api: 'modern-compiler' } },
    },
    server: {
      fs: { allow: [nebulixRoot, '.'] },
    },
  },
});
