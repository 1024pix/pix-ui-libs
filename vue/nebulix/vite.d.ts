import type { Plugin } from 'vite';

/** URL under which the fonts and the icon sprite are served by default. */
export declare const ASSETS_URL: string;

/**
 * Vite plugin for apps using `@1024pix/nebulix-vue`: adds Nebulix's Sass to
 * `loadPaths` and serves the fonts and the icon sprite under
 * `/@1024pix/nebulix-vue/…`.
 */
export declare function nebulix(): Plugin;
