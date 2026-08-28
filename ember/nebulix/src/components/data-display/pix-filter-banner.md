---
title: PixFilterBanner
---

# PixFilterBanner

`PixFilterBanner` regroupe les éléments de filtres (`Select`, `MultiSelect`, `Input`... ).

> Il est possible de surcharger le style d'une `<PixFilterBanner>` via l'attribut `class`
> ainsi que de passer n'importe quel attribut sur sa div wrapper (par exemple, un `aria-label`)

## Utilisation

```gjs live preview nebulix
import { PixFilterBanner, PixSearchInput, PixSelect } from '@1024pix/nebulix-ember';

const options = [
  { label: 'Gyoza', value: '1' },
  { label: 'Udon', value: '1' },
];
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
    @isClearFilterButtonDisabled={{true}}
  >
    <PixSearchInput
      @id="filtre-nom"
      @triggerFiltering={{filtrer}}
      @debounceTimeInMs={{300}}
      placeholder="Nom ou prénom"
    >
      <:label>Rechercher</:label>
    </PixSearchInput>
    <PixSelect @placeholder="Choix" @options={{options}} @onChange={{filtrer}}><:label
      >menu</:label></PixSelect>
  </PixFilterBanner>
</template>
```

`@details` permet de préciser une information sur le filtre (ex: le nombre de résultat)

## Réinitialiser les filtres

`@onClearFilters` permet d'ajouter un handler pour réinitialiser les filtres.
Le label est personnalisable avec `@clearFiltersLabel`.

`@isClearFilterButtonDisabled` permet de désactiver le bouton quand aucun filtre
n'est actif.

## Filtrage immédiat ou à la demande

Pour un filtrage à la volée, chaque champ appelle lui-même la fonction de filtre.
Quand le filtrage est coûteux, on peut utiliser `@onLoadFilters` qui ajoute un bouton
pour déclencher le filtrage manuellement. Le label du filtre est personnalisable
avec `@loadFiltersLabel`.

```gjs live nebulix
import { PixFilterBanner, PixSearchInput, PixSelect } from '@1024pix/nebulix-ember';

const options = [
  { label: 'Gyoza', value: '1' },
  { label: 'Udon', value: '1' },
];
let search = '';
const updateSearch = () => {};
const updateSelect = () => {};

const triggerFilters = () => {};

const reinitialiser = () => {
  // votre action
};

<template>
  <PixFilterBanner
    @title="Filtrer les participants"
    @clearFiltersLabel="Effacer les filtres"
    @onClearFilters={{reinitialiser}}
    @isClearFilterButtonDisabled={{true}}
    @onLoadFilters={{triggerFilters}}
    @loadFiltersLabel="Rechercher"
  >
    <PixSearchInput
      @id="filtre-nom"
      @triggerFiltering={{updateSearch}}
      @debounceTimeInMs={{300}}
      placeholder="Nom ou prénom"
    >
      <:label>Rechercher</:label>
    </PixSearchInput>
    <PixSelect @placeholder="Choix" @options={{options}} @onChange={{updateSelect}}><:label
      >menu</:label></PixSelect>
  </PixFilterBanner>
</template>
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/data-display/pix-filter-banner'
  @name='PixFilterBannerSignature'
/>
```
