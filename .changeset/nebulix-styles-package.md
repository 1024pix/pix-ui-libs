---
"@1024pix/nebulix-ember": minor
---

Styles, fonts, icon sprite and icon map now come from the internal `@1024pix/nebulix-styles` workspace package, shared with future framework bindings, and are embedded in this package at build time.

The Sass is still published under `dist/styles`: existing `loadPaths` and `@use 'nebulix-styles'` keep working. Fonts and the icon sprite are now served under `/@1024pix/nebulix-styles/…` instead of `/@1024pix/nebulix-ember/…`; apps referencing those URLs directly must update them.
