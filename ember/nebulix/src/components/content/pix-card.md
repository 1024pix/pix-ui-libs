---
title: PixCard
---

# PixCard

`PixCard` est un bloc de fond blanc dont les bords sont arrondis.
Elle doit contenir un titre, une illustration.
Elle peut contenir un sous titre, un tag, un pied de carte

## Utilisation

```gjs live preview nebulix
import { PixCard, PixTag } from '@1024pix/nebulix-ember';

<template>
  <PixCard
    @variant="certif"
    @title="Compétences numériques 2024"
    @subtitle="Collège Jean Moulin"
    @image="https://assets.pix.org/sites/orga/parcours-apprenant.png"
  >
    <:tag><PixTag @color="green-light"> Parcours Apprenants </PixTag></:tag>
    <:description>
      Parcours d'évaluation des seize compétences du cadre de référence.
    </:description>
    <:footer>Créée le 12 mars 2024 • Accès sans compte</:footer>
  </PixCard>
</template>
```

Seul `@title` est obligatoire. Il est rendu dans un `<h3>` : vérifiez qu'il
s'insère correctement dans la hiérarchie de titres de votre page.

Les trois blocs `:tag`, `:description` et `:footer` sont facultatifs. Le titre
et le sous-titre sont tronqués s'ils débordent.

## Variantes

`@variant` modifie la couleur de l'ombre interne de la carte (voir [PixBlock](../layout/PixBlock.md))
s'affiche. Le variant `orga` ajoute un fond coloré à l'illustration.
Valeur par défaut : `orga`.

```gjs live nebulix
import { PixCard, PixTag } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-cards">
    <PixCard
      @variant="primary"
      @title="Exemple avec un titre tronqué sur plus de 2 lignes qui affiche une ellipse"
      @subtitle="Collège Jean Moulin"
      @image="https://assets.pix.org/sites/orga/parcours-apprenant.png"
    >
      <:tag><PixTag @color="green-light"> Parcours Apprenants </PixTag></:tag>
      <:description>
        Parcours d'évaluation des seize compétences du cadre de référence.
      </:description>
      <:footer>Créée le 12 mars 2024 • Accès sans compte</:footer>
    </PixCard>

    <PixCard @variant="orga" @title="Exemple sans illustration" @subtitle="Collège Jean Moulin">
      <:tag><PixTag @color="green-light"> Parcours Apprenants </PixTag></:tag>
      <:description>
        Parcours d'évaluation des seize compétences du cadre de référence.
      </:description>
      <:footer>Créée le 12 mars 2024 • Accès sans compte</:footer>
    </PixCard>

    <PixCard
      @variant="certif"
      @title="exemple sans description"
      @subtitle="Collège Jean Moulin"
      @image="https://assets.pix.org/sites/orga/parcours-apprenant.png"
    >
      <:tag><PixTag @color="yellow"> Parcours Apprenants </PixTag></:tag>

      <:footer>Créée le 12 mars 2024 • Accès sans compte</:footer>
    </PixCard>

    <PixCard
      @variant="admin"
      @title="Exemple sans tag"
      @subtitle="Collège Jean Moulin"
      @image="https://assets.pix.org/sites/orga/parcours-apprenant.png"
    >

      <:description>
        Parcours d'évaluation des seize compétences du cadre de référence.
      </:description>
      <:footer>Créée le 12 mars 2024 • Accès sans compte</:footer>
    </PixCard>
  </div>

  <style>
    .demo-cards {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 1.5rem;
      align-items: flex-start;
    }
  </style>
</template>
```

## Cartes en liste

Le contenu peut être affiché à droite de l'image en passant `@wide="true"`.

```gjs live nebulix
import { PixCard, PixTag } from '@1024pix/nebulix-ember';

<template>
  <PixCard
    @title="Certification Pix"
    @subtitle="Session du 4 juin"
    @image="https://assets.pix.org/sites/orga/parcours-apprenant.png"
    @wide="true"
  >
    <:tag><PixTag @color="green-light">Ouverte</PixTag></:tag>
    <:description>Douze candidats inscrits sur seize places.</:description>
    <:footer>Salle B12</:footer>
  </PixCard>
</template>
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/content/pix-card'
  @name='PixCardSignature'
/>
```
