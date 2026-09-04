---
title: PixToggle
new: true
---

# PixToggle

Le PixToggle est un interrupteur : il permet à l'utilisateur d'activer ou de désactiver un réglage, dont l'effet est immédiat et ne nécessite pas de validation.

Si le réglage n'est appliqué qu'après la soumission d'un formulaire, utiliser une [PixCheckbox](./pix-checkbox.md) à la place.

Le composant repose sur une case à cocher native portant le rôle `switch`, son label est cliquable et il est activable au clavier avec la barre d'espace.

## Utilisation

Le libellé passe par le bloc par défaut.

L'état d'activation est piloté par le consommateur via `@checked` : le composant ne le mémorise pas. Il faut donc écouter l'évènement `change` pour le mettre à jour.

```gjs live preview nebulix
import { PixToggle } from '@1024pix/nebulix-ember';

import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';

export default class ToggleDemo extends Component {
  @tracked
  isSubscribedToNewsletter = false;

  toggleNewsletterSubscription = (event) => {
    this.isSubscribedToNewsletter = event.target.checked;
  };

  <template>
    <PixToggle
      @checked={{this.isSubscribedToNewsletter}}
      {{on "change" this.toggleNewsletterSubscription}}
    >
      Recevoir la newsletter
    </PixToggle>
  </template>
}
```

Tout attribut passé au composant (`aria-label`, `data-*`, modifieur `{{on "change"}}`, ...) est appliqué à la case à cocher.

## Toggle désactivé

L'attribut `@isDisabled` désactive le toggle en conservant la possibilité de naviguer avec le clavier ou le lecteur d'écran. Il est préféré à l'attribut natif `disabled` qui empêche ces usages.

```gjs live nebulix
import { PixToggle } from '@1024pix/nebulix-ember';

<template>
  <PixToggle @checked={{true}} @isDisabled={{true}}>
    Notifications par e-mail
  </PixToggle>
</template>
```

## Tailles

`@size` accepte `small` (par défaut) et `large`. La taille s'applique au toggle comme à son libellé.

```gjs live preview nebulix
import { PixToggle } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-stack">
    <PixToggle @checked={{true}}>Recevoir la newsletter</PixToggle>

    <PixToggle @size="large" @checked={{true}}>Recevoir la newsletter</PixToggle>
  </div>

  <style>
    .demo-stack {
      display: flex;
      flex-direction: column;
      gap: 0.75rem;
      align-items: flex-start;
    }
  </style>
</template>
```

## Accessibilité

Le label est facultatif. Lorsqu'aucun label visible n'est passé en bloc, il est impératif de nommer le toggle avec un `aria-label`, sans quoi il est inutilisable au lecteur d'écran.

```gjs preview nebulix
import { PixToggle } from '@1024pix/nebulix-ember';

<template><PixToggle aria-label="Recevoir la newsletter" /></template>
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-toggle'
  @name='PixToggleSignature'
/>
```
