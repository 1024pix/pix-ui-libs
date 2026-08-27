---
title: PixStars
---

# PixStars

`PixStars` représente un score sous forme d'étoiles : le niveau atteint sur un
sujet, la difficulté d'un parcours.

## Utilisation

```gjs live preview nebulix
import { PixStars } from '@1024pix/nebulix-ember';

<template><PixStars @count={{3}} @total={{5}} @alt="Niveau 3 sur 5" /></template>
```

`@alt` est la seule information transmise aux lecteurs d'écran : les étoiles
leur sont masquées. Écrivez-y le score en toutes lettres, jamais « étoiles »
seul.

Sans `@total`, seules les étoiles obtenues sont affichées — l'utilisateur perd
alors le point de comparaison. Renseignez-le dès que le maximum a du sens.

## Couleurs

```gjs live nebulix
import { PixStars } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-stars">
    <figure>
      <PixStars @count={{4}} @total={{5}} @color="primary" @alt="Niveau 4 sur 5" />
      <figcaption>primary</figcaption>
    </figure>

    <figure>
      <PixStars @count={{4}} @total={{5}} @color="neutral" @alt="Niveau 4 sur 5" />
      <figcaption>neutral</figcaption>
    </figure>
  </div>

  <style>
    .demo-stars {
      display: flex;
      flex-wrap: wrap;
      gap: 1.5rem;
      align-items: flex-start;
    }

    .demo-stars figure {
      display: flex;
      flex-direction: column;
      gap: 0.5rem;
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
