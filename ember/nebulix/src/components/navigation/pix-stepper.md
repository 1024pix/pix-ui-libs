---
title: PixStepper
---

# PixStepper

`PixStepper` montre les étapes d'un parcours en plusieurs temps — une
inscription, un import, une création de campagne — et situe l'utilisateur dans
cette suite.

Il informe, il ne navigue pas : les étapes ne sont pas cliquables. C'est à
votre écran de fournir les boutons « Précédent » et « Suivant ».

## Utilisation

```gjs live preview nebulix
import { PixStepper } from '@1024pix/nebulix-ember';

const etapes = [
  { title: 'Informations', subtitle: 'Nom et objectif' },
  { title: 'Participants', subtitle: 'Import de la liste' },
  { title: 'Vérification', subtitle: 'Avant envoi' },
];

<template><PixStepper @steps={{etapes}} @currentStep={{2}} /></template>
```

`@currentStep` se compte à partir de 1. Le composant annonce aux lecteurs
d'écran la progression complète — « étape 2 sur 3 » — dans la langue indiquée
par `@locale`.

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
