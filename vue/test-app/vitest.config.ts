import vue from '@vitejs/plugin-vue';
import { defineConfig } from 'vitest/config';

// Tests import `@1024pix/nebulix-vue` as an app would: its built `dist/`, not
// its sources. Run `pnpm build` (or `pnpm dev:vue`) first.
export default defineConfig({
  plugins: [vue()],
  test: {
    environment: 'jsdom',
    setupFiles: ['tests/setup.ts'],
    include: ['tests/**/*.test.ts'],
  },
});
