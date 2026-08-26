---
title: Couleurs
---

# Couleurs

Les couleurs du design system sont exposées sous forme de variables CSS, définies dans `styles/pix-design-tokens/_colors.scss`.

Chaque variable existe en deux formes :

- `--pix-primary-500` pour un usage direct.
- `--pix-primary-500-inline` pour composer une couleur transparente, par exemple `rgb(var(--pix-primary-500-inline), 0.2)`.

## Marque

```gjs live nebulix
import { array } from '@ember/helper';
import ColorPalette from 'docs-app/components/ColorPalette';

<template>
  <ColorPalette
    @title="Primary"
    @prefix="--pix-primary-"
    @shades={{array 10 50 100 300 500 700 900}}
  />
  <ColorPalette
    @title="Secondary"
    @prefix="--pix-secondary-"
    @shades={{array 50 100 300 500 700 900}}
  />
  <ColorPalette @title="Tertiary" @prefix="--pix-tertiary-" @shades={{array 100 500 900}} />
</template>
```

## Neutres

```gjs live nebulix
import { array } from '@ember/helper';
import ColorPalette from 'docs-app/components/ColorPalette';

<template>
  <ColorPalette
    @title="Neutral"
    @prefix="--pix-neutral-"
    @shades={{array 0 20 100 300 500 800 900}}
  />
</template>
```

## États

```gjs live nebulix
import { array } from '@ember/helper';
import ColorPalette from 'docs-app/components/ColorPalette';

<template>
  <ColorPalette @title="Info" @prefix="--pix-info-" @shades={{array 50 100 300 500 700 900}} />
  <ColorPalette
    @title="Success"
    @prefix="--pix-success-"
    @shades={{array 50 100 300 500 700 900}}
  />
  <ColorPalette
    @title="Warning"
    @prefix="--pix-warning-"
    @shades={{array 50 100 300 500 700 900}}
  />
  <ColorPalette @title="Error" @prefix="--pix-error-" @shades={{array 50 100 300 500 700 900}} />
</template>
```

## Plateformes

```gjs live nebulix
import { array } from '@ember/helper';
import ColorPalette from 'docs-app/components/ColorPalette';

<template>
  <ColorPalette @title="Certif" @prefix="--pix-certif-" @shades={{array 50 300 500 700}} />
  <ColorPalette @title="Orga" @prefix="--pix-orga-" @shades={{array 50 300 500 700}} />
</template>
```

## Domaines

```gjs live nebulix
import { array } from '@ember/helper';
import ColorPalette from 'docs-app/components/ColorPalette';

<template>
  <ColorPalette
    @title="Information"
    @prefix="--pix-information-"
    @shades={{array "dark" "light"}}
  />
  <ColorPalette @title="Content" @prefix="--pix-content-" @shades={{array "dark" "light"}} />
  <ColorPalette
    @title="Communication"
    @prefix="--pix-communication-"
    @shades={{array "dark" "light"}}
  />
  <ColorPalette @title="Security" @prefix="--pix-security-" @shades={{array "dark" "light"}} />
  <ColorPalette
    @title="Environment"
    @prefix="--pix-environment-"
    @shades={{array "dark" "light"}}
  />
</template>
```

## Gradients

```gjs live nebulix
import { array } from '@ember/helper';
import ColorPalette from 'docs-app/components/ColorPalette';

<template>
  <ColorPalette
    @title="Default"
    @prefix="--pix-gradient-default-"
    @shades={{array "light" "dark"}}
  />
  <ColorPalette @title="Orga" @prefix="--pix-gradient-orga-" @shades={{array "light" "dark"}} />
  <ColorPalette @title="Certif" @prefix="--pix-gradient-certif-" @shades={{array "light" "dark"}} />
</template>
```
