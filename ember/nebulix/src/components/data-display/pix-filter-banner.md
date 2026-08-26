---
title: PixFilterBanner
---

# PixFilterBanner

`PixFilterBanner` regroupe les filtres d'une liste dans un bandeau placé
au-dessus d'elle. Il n'apporte aucun champ : vous y placez les vôtres, il leur
donne une mise en page commune et les actions qui vont avec.

## Utilisation

```gjs live preview nebulix
import { PixFilterBanner, PixSearchInput } from '@1024pix/nebulix-ember';

const filtrer = () => {
  // votre action
};

const reinitialiser = () => {
  // votre action
};

<template>
  <PixFilterBanner
    @title="Filtrer les participants"
    @details="128 résultats"
    @clearFiltersLabel="Effacer les filtres"
    @onClearFilters={{reinitialiser}}
  >
    <PixSearchInput
      @id="filtre-nom"
      @triggerFiltering={{filtrer}}
      @debounceTimeInMs={{300}}
      placeholder="Nom ou prénom"
    >
      <:label>Rechercher</:label>
    </PixSearchInput>
  </PixFilterBanner>
</template>
```

Le bandeau rend un `<form>`. Les champs passent par le bloc par défaut, dans
l'ordre où l'utilisateur est censé les parcourir.

`@details` affiche une précision à côté des actions : le nombre de résultats y
a toute sa place, car il donne un retour immédiat sur l'effet des filtres.

## Réinitialiser

`@clearFiltersLabel` fait apparaître le bouton de réinitialisation, et
`@onClearFilters` reçoit le clic. Ce bouton est indispensable dès que plusieurs
filtres se combinent : sans lui, l'utilisateur doit les défaire un par un.

`@isClearFilterButtonDisabled` le désactive quand aucun filtre n'est actif.

## Filtrage immédiat ou à la demande

Par défaut, chaque champ déclenche le filtrage de son côté, sans validation.
C'est le comportement à privilégier : le résultat suit la saisie.

Quand le filtrage est coûteux, `@loadFiltersLabel` ajoute un bouton de
validation et `@onLoadFilters` reçoit l'envoi du formulaire. Les filtres ne
s'appliquent alors qu'au clic — dites-le clairement dans le libellé du bouton.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/data-display/pix-filter-banner'
  @name='PixFilterBannerSignature'
/>
```
