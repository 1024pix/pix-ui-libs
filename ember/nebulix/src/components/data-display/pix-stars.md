---
title: PixStars
---

# PixStars

`PixStars` affiche une série d'étoiles.
Un texte alternatif `alt` doit être renseigné pour fournir l'information au
lecteur d'écran.

Pour ne pas afficher les étoiles vides, il suffit de ne pas renseigner `@total`.

## Utilisation

```gjs live preview nebulix
import { PixStars } from '@1024pix/nebulix-ember';

<template><PixStars @count={{3}} @total={{5}} @alt="Niveau 3 sur 5" /></template>
```

## Affichage sans étoile vides

```gjs live nebulix
import { PixStars } from '@1024pix/nebulix-ember';

<template><PixStars @count={{3}} @alt="Niveau 3" /></template>
```

## Couleurs

```gjs live nebulix
import { PixStars } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-stars">
    <figure>
      <PixStars @count={{4}} @total={{5}} @color="primary" @alt="Niveau 4 sur 5" />
      <figcaption>primary</figcaption>
    </figure>
  </div>

  <style>
    .demo-stars figure {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin: 0;
    }

    .demo-stars figcaption {
      font-family: monospace;
      font-size: 0.8rem;
      color: var(--pix-neutral-500);
    }
  </style>
</template>
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/data-display/pix-stars'
  @name='PixStarsSignature'
/>
```
