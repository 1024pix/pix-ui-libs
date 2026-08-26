---
title: PixSearchInput
---

# PixSearchInput

`PixSearchInput` filtre une liste au fil de la frappe. Il attend une pause dans
la saisie avant de déclencher la recherche, pour éviter une requête à chaque
caractère.

## Utilisation

```gjs live preview nebulix
import { PixSearchInput } from '@1024pix/nebulix-ember';

const rechercher = () => {
  // votre action
};

<template>
  <PixSearchInput
    @id="recherche-eleve"
    @triggerFiltering={{rechercher}}
    @debounceTimeInMs={{300}}
    placeholder="Nom ou prénom"
  >
    <:label>Rechercher un élève</:label>
  </PixSearchInput>
</template>
```

`@triggerFiltering` et `@debounceTimeInMs` sont **obligatoires** : sans eux, le
composant lève une erreur. `@triggerFiltering` est appelée avec l'identifiant du
champ et le texte saisi.

## Choisir le délai

`@debounceTimeInMs` est le temps d'attente après la dernière frappe. Trop court,
il multiplie les requêtes ; trop long, la liste semble figée. Une valeur autour
de 300 ms convient à une recherche côté serveur.

## Valeur initiale

`@value` ne sert qu'à préremplir le champ au premier rendu — le composant ne
suit pas ses changements ultérieurs. Pour réinitialiser une recherche depuis
l'extérieur, il faut donc recréer le composant.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-search-input'
  @name='PixSearchInputSignature'
/>
```
