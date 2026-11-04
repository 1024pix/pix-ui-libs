# @1024pix/nebulix-styles

> **Internal package, never published.** Framework packages
> (`@1024pix/nebulix-ember`, …) list it as a `devDependency` and embed what
> they need at build time. A change here is only released through a changeset
> on each framework package that must ship it.

Styles, fonts and icon sprite of the Pix Design-System, independent of any
framework. Framework bindings (`@1024pix/nebulix-ember`, …) render the BEM
class names defined here (`pix-button`, `pix-button--size-small`, …): those
class names are the contract shared by every binding.

## Content

| Export                                       | What                                                                |
| -------------------------------------------- | ------------------------------------------------------------------- |
| `@1024pix/nebulix-styles/nebulix.css`        | Compiled stylesheet: reset, design tokens, every component style.   |
| `@1024pix/nebulix-styles/tokens.css`         | Compiled design tokens only (custom properties, fonts, typography). |
| `@1024pix/nebulix-styles/scss/…`             | Sass sources (`src/`), to use mixins and placeholders.              |
| `@1024pix/nebulix-styles/icons`              | `ICONS`: icon names mapped to symbol ids of the sprite.             |
| `@1024pix/nebulix-styles/svg/pix-sprite.svg` | Icon sprite.                                                        |
| `@1024pix/nebulix-styles/fonts/…`            | `woff2` fonts.                                                      |

## Using the compiled CSS

```js
import '@1024pix/nebulix-styles/nebulix.css';
```

Fonts are referenced relatively (`../assets/fonts/…`), so a bundler such as
Vite resolves and emits them.

## Using the Sass sources

Add `node_modules/@1024pix/nebulix-styles/src/styles` to Sass `loadPaths`, then:

```scss
@use 'nebulix-styles';
```

Fonts are then loaded from `$nebulix-assets-url` (default
`/@1024pix/nebulix-styles`), where the app must serve the content of
`assets/`. Override it before anything else:

```scss
@use 'config' with (
  $nebulix-assets-url: '/static/nebulix'
);
@use 'nebulix-styles';
```

## Icons

```js
import { ICONS } from '@1024pix/nebulix-styles/icons';
// <svg><use href="<sprite url>#${ICONS.add.default}" /></svg>
```

To add an icon, see `docs/developpement/add-icon.md` in `ember/nebulix`.

## Development

```bash
pnpm build                 # compile dist/*.css
pnpm dev                   # same, in watch mode
pnpm svg:generate-sprite   # rebuild assets/svg/pix-sprite.svg from tooling/
```
