---
title: PixStepper
---

# PixStepper

`PixStepper` permet d'afficher une progression par étapes. Chaque étape
peut avoir un titre et un sous-titre optionnel. Le composant nécessite
une propriété `texts` contenant une clé `ariaLabel` contenant la valeur traduite
du aria-label du composant. Au-delà de 3 étapes, le stepper adapte automatiquement
son affichage (mode long).

## Utilisation

```gjs live preview nebulix
import { PixStepper } from '@1024pix/nebulix-ember';

const etapes = [
  { title: 'Informations', subtitle: 'Nom et objectif' },
  { title: 'Participants', subtitle: 'Import de la liste' },
  { title: 'Vérification', subtitle: 'Avant envoi' },
];

const texts = {
  ariaLabel: 'Étape 2 sur 3',
};

<template><PixStepper @steps={{etapes}} @currentStep={{2}} @texts={{texts}} /></template>
```

`@currentStep` se compte à partir de 1. `@texts.ariaLabel` fournit le résumé
de la progression annoncé aux lecteurs d'écran — « étape 2 sur 3 ». Nebulix ne
traduit rien lui-même : c'est à l'application consommatrice de fournir ce
texte, déjà traduit et déjà calculé.

Nommez les étapes par ce qu'on y fait, en un ou deux mots. `subtitle` accueille
la précision.

Restez entre trois et cinq étapes : en deçà, le repère est inutile ; au-delà,
il décourage. Au-dessus de trois étapes, l'affichage passe automatiquement en
version allongée.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/navigation/pix-stepper'
  @name='PixStepperSignature'
/>
```
