import type { Page } from 'kolay';

/**
 * Turns a file or folder name into nav-ready text: the ordering prefix goes
 * away, separators become spaces, and the first letter is capitalized.
 * `01-getting-started` -> `Getting started`
 */
export function humanize(name: string): string {
  const words = name
    .replace(/^\d+[-_]?/, '')
    .replaceAll(/[-_]/g, ' ')
    .trim();

  return words.charAt(0).toUpperCase() + words.slice(1);
}

/**
 * The nav text for a page: an authored title wins over the derived name,
 * whether it comes from the page's sibling json config (`title`) or from its
 * frontmatter (`meta.title`).
 */
export function labelFor(page: Page): string {
  const frontmatterTitle = page.meta?.['title'];

  if (page.title) return page.title;
  if (typeof frontmatterTitle === 'string') return frontmatterTitle;

  return humanize(page.name);
}
