export interface IconDefinition {
  /** Symbol id of the outlined icon in `pix-sprite.svg`. */
  default: string;
  /** Symbol id of the filled variant, when the icon has one. */
  plainIcon?: string;
}

/** Icon names accepted by the PixIcon components, mapped to sprite symbol ids. */
export declare const ICONS: Record<string, IconDefinition>;
