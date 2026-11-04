// The icon map lives with the sprite it points into, in the internal
// `@1024pix/nebulix-styles` package. That package is not published: at build
// time, `rollup-plugin-styles-assets.mjs` swaps this module for the content of
// `@1024pix/nebulix-styles/icons`, so the published addon does not import it.
import { ICONS as SHARED_ICONS } from '@1024pix/nebulix-styles/icons';

/** @type {Record<string, { default: string, plainIcon?: string }>} */
export const ICONS = SHARED_ICONS;
