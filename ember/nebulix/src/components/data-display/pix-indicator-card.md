---
title: PixIndicatorCard
---

# PixIndicatorCard

`PixIndicatorCard` met en avant un chiffre clé dans un tableau de bord : un
nombre de participants, un taux de réussite, une moyenne.

Une carte, un chiffre. Si vous avez besoin d'en présenter plusieurs ensemble,
alignez plusieurs cartes plutôt que d'en surcharger une.

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

Le bloc par défaut accueille la valeur, `:sub` la précision qui l'éclaire.
`@title` dit ce qui est mesuré : gardez-le nominal et court.

## Couleur de l'icône

`@color` colore le fond de l'icône. Elle sert à distinguer les cartes les unes
des autres dans un tableau de bord, pas à qualifier la valeur : une même
famille d'indicateurs garde la même couleur d'un écran à l'autre.

```gjs live nebulix
import { PixIndicatorCard } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-indicators">
    <PixIndicatorCard @title="Participants" @iconName="users" @color="primary">
      <:default>1 248</:default>
    </PixIndicatorCard>

    <PixIndicatorCard @title="Parcours terminés" @iconName="checkCircle" @color="success">
      <:default>892</:default>
    </PixIndicatorCard>

    <PixIndicatorCard @title="En attente" @iconName="time" @color="warning">
      <:default>356</:default>
    </PixIndicatorCard>
  </div>

  <style>
    .demo-indicators {
      display: flex;
      flex-wrap: wrap;
      gap: 1.5rem;
      align-items: flex-start;
    }
  </style>
</template>
```

## Expliquer le calcul

`@info` affiche une infobulle au survol d'une icône d'information. Utilisez-la
dès qu'un chiffre peut prêter à interprétation — ce que recouvre exactement un
« participant », sur quelle période, avec quelles exclusions.

`@infoLabel` nomme cette icône pour les lecteurs d'écran : sans lui, l'aide
reste inaccessible au clavier.

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

L'infobulle est masquée sur mobile : n'y placez jamais une information
indispensable à la lecture du chiffre.

## Chargement

`@isLoading` affiche un squelette pendant que la donnée arrive.
`@loadingMessage` est annoncé aux lecteurs d'écran à ce moment-là : sans lui,
l'attente est silencieuse.

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
