---
title: PixCard
---

# PixCard

`PixCard` présente un objet dans une liste — une campagne, un parcours, un
établissement — sous une forme homogène : un titre, un sous-titre, une
description et un pied de carte.

## Utilisation

```gjs live preview nebulix
import { PixCard } from '@1024pix/nebulix-ember';

<template>
  <PixCard @title="Compétences numériques 2024" @subtitle="Collège Jean Moulin">
    <:description>
      Parcours d'évaluation des seize compétences du cadre de référence.
    </:description>
    <:footer>Créée le 12 mars 2024</:footer>
  </PixCard>
</template>
```

Seul `@title` est obligatoire. Il est rendu dans un `<h3>` : vérifiez qu'il
s'insère correctement dans la hiérarchie de titres de votre page.

Les trois blocs `:tag`, `:description` et `:footer` sont facultatifs. Le titre
et le sous-titre sont tronqués s'ils débordent, l'intitulé complet restant
accessible en infobulle : gardez-les courts plutôt que de compter dessus.

## Variantes

`@variant` accorde la carte aux couleurs de l'application dans laquelle elle
s'affiche. Par défaut : `orga`.

```gjs live nebulix
import { PixCard } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-cards">
    <PixCard @title="Carte" @subtitle="primary" @variant="primary">
      <:description>Application Pix</:description>
    </PixCard>

    <PixCard @title="Carte" @subtitle="orga" @variant="orga">
      <:description>Pix Orga</:description>
    </PixCard>

    <PixCard @title="Carte" @subtitle="certif" @variant="certif">
      <:description>Pix Certif</:description>
    </PixCard>

    <PixCard @title="Carte" @subtitle="admin" @variant="admin">
      <:description>Pix Admin</:description>
    </PixCard>
  </div>

  <style>
    .demo-cards {
      display: flex;
      flex-wrap: wrap;
      gap: 1.5rem;
      align-items: flex-start;
    }
  </style>
</template>
```

## Étiquette et illustration

Le bloc `:tag` accueille un `PixTag` en tête de carte, pour signaler un état.
`@image` ajoute une illustration : elle est décorative et masquée aux lecteurs
d'écran, ne lui confiez donc aucune information.

```gjs live nebulix
import { PixCard, PixTag } from '@1024pix/nebulix-ember';

<template>
  <PixCard @title="Certification Pix" @subtitle="Session du 4 juin">
    <:tag><PixTag @color="green-light">Ouverte</PixTag></:tag>
    <:description>Douze candidats inscrits sur seize places.</:description>
    <:footer>Salle B12</:footer>
  </PixCard>
</template>
```

## Cartes en liste

`@wide` étend la carte à toute la largeur disponible, pour une liste en colonne
plutôt qu'en grille. Gardez le même choix pour toutes les cartes d'une même
liste.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/content/pix-card'
  @name='PixCardSignature'
/>
```
