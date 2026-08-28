---
title: PixIndicatorCard
---

# PixIndicatorCard

`PixIndicatorCard` permet de mettre en avant un chiffre dans une carte.

## Utilisation

```gjs live preview nebulix
import { PixIndicatorCard } from '@1024pix/nebulix-ember';

<template>
  <PixIndicatorCard @title="Participants" @iconName="users" @color="primary">
    <:default>1 248</:default>
    <:sub>sur 1 500 invités</:sub>
  </PixIndicatorCard>
</template>
```

`@title` renseigne sur l'unité (ex: Nombre de participants).
Le composant contient deux blocs :

- `:default` accueille la valeur numérique
- `:sub` un texte explicatif qui sera en dessous de la valeur

## Couleur de l'icône

On peut personaliser la couleur `@color` et l'icone utilisée avec `@iconName`
et `@plainIcon`.

```gjs live nebulix
import { PixIndicatorCard } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-indicators">
    <PixIndicatorCard @title="Participants" @iconName="users" @color="primary">
      <:default>1 248</:default>
      <:sub>@color=primary</:sub>
    </PixIndicatorCard>

    <PixIndicatorCard @title="Parcours terminés" @iconName="checkCircle" @color="success">
      <:default>892</:default>
      <:sub>color: success</:sub>
    </PixIndicatorCard>

    <PixIndicatorCard @title="En attente" @iconName="time" @color="warning">
      <:default>356</:default>
      <:sub>color: warning</:sub>
    </PixIndicatorCard>
  </div>

  <style>
    .demo-indicators {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 1.5rem;
    }
    pre  {
    }
  </style>
</template>
```

## Affichage d'une info bulle

Il est possible de rajouter une infobulle pour enrichir l'information
(préciser un calcul, une unité).

```gjs live nebulix
import { PixIndicatorCard } from '@1024pix/nebulix-ember';

<template>
  <PixIndicatorCard
    @title="Taux de participation"
    @iconName="percent"
    @color="tertiary"
    @info="Part des invités ayant commencé le parcours, quelle que soit leur progression."
    @infoLabel="En savoir plus sur le taux de participation"
  >
    <:default>83 %</:default>
    <:sub>+ 4 points depuis la semaine dernière</:sub>
  </PixIndicatorCard>
</template>
```

## Chargement

`@isLoading` affiche un squelette pendant que la donnée arrive.
`@loadingMessage` permet d'informer les lecteurs d'écran.

```gjs live nebulix
import { PixIndicatorCard } from '@1024pix/nebulix-ember';

<template>
  <PixIndicatorCard
    @title="Participants"
    @iconName="users"
    @isLoading={{true}}
    @loadingMessage="Chargement du nombre de participants"
  >
    <:default>—</:default>
  </PixIndicatorCard>
</template>
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/data-display/pix-indicator-card'
  @name='PixIndicatorCardSignature'
/>
```
