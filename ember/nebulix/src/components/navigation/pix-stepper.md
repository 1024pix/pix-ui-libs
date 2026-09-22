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
  { title: 'Informations', subtitle: 'Renseignez vos informations' },
  { title: 'Confirmation', subtitle: 'Vérifiez vos données' },
  { title: 'Validation', subtitle: 'Finalisez votre inscription' },
];

const texts = {
  ariaLabel: 'Étape 1 sur 3',
};

<template><PixStepper @steps={{etapes}} @currentStep={{1}} @texts={{texts}} /></template>
```

`@currentStep` se compte à partir de 1. `@texts.ariaLabel` fournit le résumé
de la progression annoncé aux lecteurs d'écran — « étape 2 sur 3 ». Nebulix ne
traduit rien lui-même : c'est à l'application consommatrice de fournir ce
texte, déjà traduit et déjà calculé.

`subtitle` accueille la précision d'une étape.

Au-dessus de trois étapes, l'affichage passe automatiquement en
version allongée.

## Étape intermédiaire

```gjs live preview nebulix
import { PixStepper } from '@1024pix/nebulix-ember';

const etapes = [
  { title: 'Informations', subtitle: 'Renseignez vos informations' },
  { title: 'Confirmation', subtitle: 'Vérifiez vos données' },
  { title: 'Validation', subtitle: 'Finalisez votre inscription' },
];

const texts = {
  ariaLabel: 'Étape 2 sur 3',
};

<template><PixStepper @steps={{etapes}} @currentStep={{2}} @texts={{texts}} /></template>
```

## Stepper long (plus de 3 étapes)

```gjs live preview nebulix
import { PixStepper } from '@1024pix/nebulix-ember';

const etapes = [
  { title: 'Étape 1', subtitle: 'Description de la première étape' },
  { title: 'Étape 2', subtitle: 'Description de la deuxième étape' },
  { title: 'Étape 3', subtitle: 'Description de la troisième étape' },
  { title: 'Étape 4', subtitle: 'Description de la quatrième étape' },
  { title: 'Étape 5', subtitle: 'Description de la cinquième étape' },
];

const texts = {
  ariaLabel: 'Étape 3 sur 5',
};

<template><PixStepper @steps={{etapes}} @currentStep={{3}} @texts={{texts}} /></template>
```

## Sans sous-titre

```gjs live preview nebulix
import { PixStepper } from '@1024pix/nebulix-ember';

const etapes = [{ title: 'Étape 1' }, { title: 'Étape 2' }, { title: 'Étape 3' }];

const texts = {
  ariaLabel: 'Étape 2 sur 3',
};

<template><PixStepper @steps={{etapes}} @currentStep={{2}} @texts={{texts}} /></template>
```

## Navigable

Fournir `@onStepClick` active le mode navigation. Toutes les étapes deviennent cliquables et le callback est appelé avec le numéro de l'étape au clic. Cliquez sur les étapes pour voir le stepper se mettre à jour.

```gjs live preview nebulix
import { PixStepper } from '@1024pix/nebulix-ember';
import { fn } from '@ember/helper';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

const steps = [
  { title: 'Informations', subtitle: 'Renseignez vos informations' },
  { title: 'Confirmation', subtitle: 'Vérifiez vos données' },
  { title: 'Validation', subtitle: 'Finalisez votre inscription' },
  { title: 'Finalisation', subtitle: 'Complétez votre dossier' },
];

const texts = {
  ariaLabel: 'Étape 3 sur 4',
};

export default class PixStepperDemo extends Component {
  @tracked currentStep = 3;

  <template>
    <PixStepper
      @steps={{steps}}
      @currentStep={{this.currentStep}}
      @texts={{texts}}
      @onStepClick={{fn (mut this.currentStep)}}
    />
  </template>
}
```

## Navigable avec restriction

`@canNavigateTo` permet de restreindre les étapes accessibles. Ici, seule l'étape 2 est cliquable depuis l'étape 3 (navigation arrière uniquement, étape 1 bloquée).

```gjs live preview nebulix
import { PixStepper } from '@1024pix/nebulix-ember';
import { fn } from '@ember/helper';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';

const steps = [
  { title: 'Informations', subtitle: 'Renseignez vos informations' },
  { title: 'Confirmation', subtitle: 'Vérifiez vos données' },
  { title: 'Validation', subtitle: 'Finalisez votre inscription' },
  { title: 'Finalisation', subtitle: 'Complétez votre dossier' },
];

const texts = {
  ariaLabel: 'Étape 3 sur 4',
};

export default class PixStepperRestrictedNavigationDemo extends Component {
  @tracked currentStep = 3;

  @action
  canNavigateTo(n) {
    return n > 1 && n < 3;
  }

  <template>
    <PixStepper
      @steps={{steps}}
      @currentStep={{this.currentStep}}
      @texts={{texts}}
      @onStepClick={{fn (mut this.currentStep)}}
      @canNavigateTo={{this.canNavigateTo}}
    />
  </template>
}
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/navigation/pix-stepper'
  @name='PixStepperSignature'
/>
```
