---
title: PixProgressBar
---

# PixProgressBar

`PixProgressBar` permet d'afficher un barre de progression sur un ratio de 0 à 1.
Des paramètres existent pour changer le mode (dark ou light) ou la couleur du composant.

`@value` est la valeur entre 0 et 1.

`@percentageValue` est le texte affiché à coté de la barre.

`@label` pour rendre le composant accessible, sauf si le composant est utilisé
uniquement pour de la décoration. Dans ce cas, mettre le paramètre `@isDecorative`
à true.

On peut completer l'information avec `@subtitle`

## Utilisation

```gjs live preview nebulix
import { PixProgressBar } from '@1024pix/nebulix-ember';

<template>
  <PixProgressBar
    @value={{0.65}}
    @percentageValue="65 %"
    @label="Progression dans le parcours"
    @subtitle="Progression"
    @hidePercentage={{true}}
  />
</template>
```

## Couleur et fond

`@color` accorde la barre à son contexte.
Les valeurs supportées sont `primary`, `success` et `tertiary`.

`@themeMode="dark"` l'adapte à un fond sombre.

```gjs live nebulix
import { PixProgressBar } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-bars">
    <PixProgressBar @value={{0.4}} @percentageValue="40 %" @label="primary" />
    <PixProgressBar @value={{0.6}} @percentageValue="60 %" @color="success" @label="success" />
    <PixProgressBar @value={{0.8}} @percentageValue="80 %" @color="tertiary" @label="tertiary" />
    <div class="demo-dark">
      <PixProgressBar @value={{0.4}} @percentageValue="40 %" @label="primary" @themeMode="dark" />
    </div>
  </div>

  <style>
    .demo-bars {
      display: flex;
      flex-direction: column;
      gap: 1.5rem;
    }
    .demo-dark {
      padding: var(--pix-spacing-2x);
      background-color: var(--pix-tertiary-900);
    }
  </style>
</template>
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/data-display/pix-progress-bar'
  @name='PixProgressBarSignature'
/>
```
