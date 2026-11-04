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

| Export                                       | What                                                    |
| -------------------------------------------- | ------------------------------------------------------- |
| `@1024pix/nebulix-styles/scss/…`             | Sass sources (`src/`).                                  |
| `@1024pix/nebulix-styles/icons`              | `ICONS`: icon names mapped to symbol ids of the sprite. |
| `@1024pix/nebulix-styles/svg/pix-sprite.svg` | Icon sprite.                                            |
| `@1024pix/nebulix-styles/fonts/…`            | `woff2` fonts.                                          |

Only Sass is shipped for now: framework packages republish it as-is and apps
compile it themselves, with `src/styles` on their Sass `loadPaths`:

```scss
@use 'nebulix-styles';
```

Fonts are loaded from the absolute URL `/@1024pix/nebulix-ember/fonts/…`
(hardcoded in `pix-design-tokens/_fonts.scss`), where the framework package
serves the content of `assets/`.

## Icons

```js
import { ICONS } from '@1024pix/nebulix-styles/icons';
// <svg><use href="<sprite url>#${ICONS.add.default}" /></svg>
```

To add an icon, see `docs/developpement/add-icon.md` in `ember/nebulix`.

## Development

There is no build step: framework packages read `src/` and `assets/` directly.

```bash
pnpm svg:generate-sprite   # rebuild assets/svg/pix-sprite.svg from tooling/
```
