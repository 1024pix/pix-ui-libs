---
title: Espacements
---

# Espacements

Les espacements du design system sont exposés sous forme de variables CSS, définies dans `styles/pix-design-tokens/_spacing.scss`.

Une variable s'utilise partout où une distance est attendue : margins, paddings, gap, etc.

```css
.ma-carte {
  padding: var(--pix-spacing-4x);
  gap: var(--pix-spacing-2x);
}
```

## L'échelle

Chaque palier ajoute 4 pixels au précédent, et le nom donne le multiplicateur : `--pix-spacing-6x` vaut six fois 4 pixels, soit 24 pixels.

```gjs live nebulix
import { array } from '@ember/helper';
import SpacingScale from 'docs-app/components/SpacingScale';

<template>
  <SpacingScale
    @prefix="--pix-spacing-"
    @names={{array "1x" "2x" "3x" "4x" "5x" "6x" "7x" "8x" "9x" "10x" "11x" "12x"}}
  />
</template>
```
