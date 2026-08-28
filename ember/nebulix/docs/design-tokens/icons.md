---
title: Icônes
---

# Icônes

Les icônes sont fournies par un sprite SVG unique, généré à partir des fichiers de `tooling/generate-svg-sprite/icons` (voir [documentation](/nebulix/developpement/add-icon.md)), et s'affichent avec le composant `PixIcon`.

Chaque icône existe **en version contour et/ou en version pleine** avec `@plainIcon`.

```hbs
<!-- Icône en version contour -->
<PixIcon @name='bell' @title='Notifications' />

<!-- Icône en version pleine -->
<PixIcon @name='bell' @title='Notifications' @plainIcon={{true}} />
```

Dans la galerie ci-dessous, cliquez sur une icône pour copier son nom.

```gjs live nebulix
import IconGallery from 'docs-app/components/IconGallery';

<template><IconGallery /></template>
```
