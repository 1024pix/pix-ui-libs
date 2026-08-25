import rehypeShiki from '@shikijs/rehype';
import { defineConfig } from 'kolay/vite';

export default defineConfig({
  docs: [{ name: 'Nebulix', src: import.meta.resolve('../nebulix/docs') }],

  apiDocs: ['@1024pix/nebulix-ember'],

  markdownOptions: {
    rehypePlugins: [
      [
        rehypeShiki,
        {
          themes: { light: 'github-light', dark: 'github-dark' },
          defaultColor: 'light-dark()',
        },
      ],
    ],
    scope: `
      import { APIDocs, CommentQuery, ComponentSignature, HelperSignature, ModifierSignature } from 'kolay';
      import { Shadowed } from 'ember-primitives/components/shadowed';
      import { InViewport } from 'ember-primitives/viewport';
      `,
  },
});
