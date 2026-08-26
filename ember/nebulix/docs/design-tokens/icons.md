---
title: Icônes
---

# Icônes

Les icônes sont fournies par un sprite SVG unique, généré à partir des fichiers de `tooling/generate-svg-sprite/icons`, et s'affichent avec le composant `PixIcon`.

Chaque icône existe en version contour. Certaines ont aussi une version pleine, que l'on obtient avec `@plainIcon`.

```hbs
<PixIcon @name='bell' @title='Notifications' />
<PixIcon @name='bell' @plainIcon={{true}} @title='Notifications' />
```

Dans la galerie ci-dessous, la version contour est affichée à gauche et la version pleine à droite, quand elle existe. Cliquez sur une icône pour copier son nom.

```gjs live nebulix
import IconGallery from 'docs-app/components/IconGallery';

<template>
  <IconGallery />
</template>
```
