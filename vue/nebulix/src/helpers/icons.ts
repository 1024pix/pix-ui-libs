// The icon map lives with the sprite it points into, in the internal
// `@1024pix/nebulix-styles` package. That package is not published: Vite
// bundles this import into `dist/`, and the explicit type below keeps it out of
// the declarations.
import { ICONS as SHARED_ICONS } from '@1024pix/nebulix-styles/icons';

export interface IconDefinition {
  /** Symbol id of the outlined icon in `pix-sprite.svg`. */
  default: string;
  /** Symbol id of the filled variant, when the icon has one. */
  plainIcon?: string;
}

export const ICONS: Record<string, IconDefinition> = SHARED_ICONS;
