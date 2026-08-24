import { defineConfig } from 'kolay/vite';

export default defineConfig({
  docs: [
    // { name: "Runtime", src: import.meta.resolve("../docs") },
    // a plain string works too; the last segment names the group
    { name: 'nebulix', src: import.meta.resolve('../nebulix/docs') },
    // { name: 'TestDocs', src: import.meta.resolve('../docs') },
  ],

  // apiDocs: [],

  // demos: [{ src: import.meta.resolve('./demos'), as: '#demos/site' }],

  // importEntrypoints: ['ember-primitives'],

  // redirects: [{ from: 'old-section/*', to: 'new-section/*' }],
});
