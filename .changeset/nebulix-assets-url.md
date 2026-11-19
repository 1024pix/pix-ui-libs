---
"@1024pix/nebulix-ember": patch
---

The URL of the fonts is now the Sass variable `$nebulix-assets-url` (default: `/@1024pix/nebulix-ember`, unchanged). Apps serving the fonts elsewhere can configure it: `@use 'nebulix-styles' with ($nebulix-assets-url: '…');`.
