---
"@1024pix/nebulix-ember": patch
---

Styles, fonts, icon sprite and icon map now come from the internal `@1024pix/nebulix-styles` workspace package, shared with future framework bindings, and are embedded in this package at build time.

No change for apps: the Sass is still published under `dist/styles` (existing `loadPaths` and `@use 'nebulix-styles'` keep working), and fonts and the icon sprite are still served under `/@1024pix/nebulix-ember/…`.
