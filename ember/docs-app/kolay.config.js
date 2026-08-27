import rehypeShiki from '@shikijs/rehype';
import { defineConfig } from 'kolay/vite';

export default defineConfig({
  docs: [
    { name: 'nebulix', src: import.meta.resolve('../nebulix/docs') },
    {
      name: 'components',
      src: import.meta.resolve('../nebulix/src/components'),
    },
  ],

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
      import { ComponentSignature } from 'kolay';
      `,
  },
});
