import type { InjectionKey, Plugin } from 'vue';

/** URL under which the fonts and the icon sprite are served by default. Keep in sync with `vite.js`. */
export const DEFAULT_ASSETS_URL = '/@1024pix/nebulix-vue';

export const ASSETS_URL_KEY: InjectionKey<string> = Symbol('nebulix-assets-url');

export interface NebulixOptions {
  /**
   * URL under which the app serves the content of `@1024pix/nebulix-vue/public`
   * (icon sprite, fonts). Par défaut : `/@1024pix/nebulix-vue`, served by the
   * `nebulix()` Vite plugin of `@1024pix/nebulix-vue/vite`.
   */
  assetsUrl?: string;
}

/**
 * Optional Vue plugin, only needed when the assets are not served at their
 * default URL.
 *
 * ```ts
 * app.use(createNebulix({ assetsUrl: 'https://cdn.example.com/nebulix' }));
 * ```
 */
export function createNebulix(options: NebulixOptions = {}): Plugin {
  return {
    install(app) {
      app.provide(ASSETS_URL_KEY, options.assetsUrl ?? DEFAULT_ASSETS_URL);
    },
  };
}
