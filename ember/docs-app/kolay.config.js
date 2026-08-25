import { defineConfig } from 'kolay/vite';

export default defineConfig({
  docs: [{ name: 'Nebulix', src: import.meta.resolve('../nebulix/docs') }],

  apiDocs: ['@1024pix/nebulix-ember'],

  // demos: [{ src: import.meta.resolve('./demos'), as: '#demos/site' }],

  // importEntrypoints: ['ember-primitives'],

  // redirects: [{ from: 'old-section/*', to: 'new-section/*' }],
});
