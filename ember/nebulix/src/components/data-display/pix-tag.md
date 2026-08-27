---
title: PixTag
---

# PixTag

`PixTag` affiche une information courte de catégorisation ou d'état : le statut
d'une session, le niveau d'un parcours, un filtre appliqué.

Une étiquette qualifie, elle n'agit pas. Si l'élément doit être cliquable,
c'est un bouton ou un lien qu'il vous faut.

## Utilisation

```gjs live preview nebulix
import { PixTag } from '@1024pix/nebulix-ember';

<template>
  <PixTag @color="green-light">Terminée</PixTag>
</template>
```

Gardez le texte à un ou deux mots : l'étiquette n'est pas un espace de
description.

## Couleurs

`@color` porte du sens. Choisissez la couleur pour ce qu'elle dit, pas pour son
esthétique — et surtout, ne lui faites jamais porter l'information à elle
seule : le texte doit rester compréhensible en noir et blanc.

```gjs live nebulix
import { PixTag } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-tags">
    <figure><PixTag @color="neutral">Brouillon</PixTag><figcaption>neutral</figcaption></figure>
    <figure><PixTag @color="secondary">En attente</PixTag><figcaption
      >secondary</figcaption></figure>
    <figure><PixTag @color="tertiary">En cours</PixTag><figcaption>tertiary</figcaption></figure>
    <figure><PixTag @color="success">Validée</PixTag><figcaption>success</figcaption></figure>
    <figure><PixTag @color="error">Annulée</PixTag><figcaption>error</figcaption></figure>
  </div>

  <style>
    .demo-tags {
      display: flex;
      flex-wrap: wrap;
      gap: 1.5rem;
      align-items: flex-start;
    }

    .demo-tags figure {
      display: flex;
      flex-direction: column;
      gap: 0.5rem;
      align-items: center;
      margin: 0;
    }

    .demo-tags figcaption {
      font-family: monospace;
      font-size: 0.8rem;
      color: var(--pix-neutral-500);
    }
  </style>
</template>
```

| Couleur     | Ce qu'elle exprime                          |
| ----------- | ------------------------------------------- |
| `neutral`   | Un état sans enjeu particulier.             |
| `secondary` | Une information en attente ou à surveiller. |
| `tertiary`  | Une information en cours.                   |
| `success`   | Un état favorable, terminé ou validé.       |
| `error`     | Un état bloquant ou en échec.               |

D'autres couleurs sont disponibles pour des besoins d'illustration :
`blue`, `blue-light`, `green`, `green-light`, `yellow`, `yellow-light`,
`orange`, `orange-light`, `purple`, `purple-light`, `grey`, `grey-light`,
`dark`, `white` et `orga`.

## Étiquette supprimable

`@displayRemoveButton` ajoute une croix, utile pour représenter un filtre actif
que l'utilisateur peut retirer. Le libellé du bouton est fourni par Nebulix
dans la langue indiquée par `@locale`.

```gjs live nebulix
import { PixTag } from '@1024pix/nebulix-ember';

const retirer = () => {
  // votre action
};

<template>
  <PixTag @color="tertiary" @displayRemoveButton={{true}} @onRemove={{retirer}}>
    Collège Jean Moulin
  </PixTag>
</template>
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/data-display/pix-tag'
  @name='PixTagSignature'
/>
```
