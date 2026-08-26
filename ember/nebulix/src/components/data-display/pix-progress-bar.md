---
title: PixProgressBar
---

# PixProgressBar

`PixProgressBar` montre la part accomplie d'une progression : l'avancement dans
un parcours, le taux de participation à une campagne.

## Utilisation

```gjs live preview nebulix
import { PixProgressBar } from '@1024pix/nebulix-ember';

<template>
  <PixProgressBar @value={{0.65}} @percentageValue="65 %" @label="Progression dans le parcours" />
</template>
```

`@value` est une fraction entre 0 et 1, pas un pourcentage. `@label` est
obligatoire : c'est le seul intitulé dont disposent les lecteurs d'écran.

`@percentageValue` est le texte affiché au-dessus de la barre. Il est purement
décoratif — c'est à vous de le formater, y compris l'unité.

## Couleur et fond

`@color` accorde la barre à son contexte. `@themeMode="dark"` l'adapte à un
fond sombre.

```gjs live nebulix
import { PixProgressBar } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-bars">
    <PixProgressBar @value={{0.4}} @percentageValue="40 %" @label="primary" />
    <PixProgressBar @value={{0.6}} @percentageValue="60 %" @color="success" @label="success" />
    <PixProgressBar @value={{0.8}} @percentageValue="80 %" @color="tertiary" @label="tertiary" />
  </div>

  <style>
    .demo-bars {
      display: flex;
      flex-direction: column;
      gap: 1.5rem;
    }
  </style>
</template>
```

Les valeurs `blue`, `green` et `purple` sont dépréciées : préférez `primary`,
`success` et `tertiary`.

## Sobriété

`@hidePercentage` retire le chiffre, `@subtitle` ajoute une précision sous la
barre. Une barre sans chiffre se lit plus vite ; une barre sans chiffre ni
sous-titre ne dit plus rien de précis.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/data-display/pix-progress-bar'
  @name='PixProgressBarSignature'
/>
```
