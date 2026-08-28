---
title: PixSwitch
new: true
---

# PixSwitch

`PixSwitch` est un contrôle de formulaire qui bascule entre deux états : activé ou désactivé.
Il sert à activer ou désactiver une option, une fonctionnalité, ou toute préférence booléenne.

Quand il faut cocher plusieurs réponses indépendantes, utilisez plutôt `PixCheckbox`.

## Utilisation

```gjs live preview nebulix
import { PixSwitch } from '@1024pix/nebulix-ember';

<template><PixSwitch @id="notifications" /></template>
```

Le switch peut être initialement activé avec `@checked={{true}}`.

## Variants

Trois variantes de couleur permettent de différencier le switch selon son contexte : admin (bleu), orga (vert), certif (orange).

```gjs live nebulix
import { PixSwitch } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-variants">
    <div class="demo-variant">
      <p>Admin (défaut)</p>
      <PixSwitch @variant="admin" @checked={{true}} />
    </div>
    <div class="demo-variant">
      <p>Orga</p>
      <PixSwitch @variant="orga" @checked={{true}} />
    </div>
    <div class="demo-variant">
      <p>Certif</p>
      <PixSwitch @variant="certif" @checked={{true}} />
    </div>
  </div>

  <style>
    .demo-variants {
      display: flex;
      flex-direction: column;
      gap: 1.5rem;
    }
    .demo-variant p {
      margin: 0 0 0.5rem 0;
      font-size: 0.875rem;
      color: var(--pix-neutral-700);
    }
  </style>
</template>
```

## Tailles

Le switch s'adapte à trois tailles : petite, moyenne (défaut), grande.

```gjs live nebulix
import { PixSwitch } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-sizes">
    <div class="demo-size">
      <p>Small</p>
      <PixSwitch @size="small" @checked={{true}} />
    </div>
    <div class="demo-size">
      <p>Medium (défaut)</p>
      <PixSwitch @size="medium" @checked={{true}} />
    </div>
    <div class="demo-size">
      <p>Large</p>
      <PixSwitch @size="large" @checked={{true}} />
    </div>
  </div>

  <style>
    .demo-sizes {
      display: flex;
      flex-direction: column;
      gap: 1.5rem;
    }
    .demo-size p {
      margin: 0 0 0.5rem 0;
      font-size: 0.875rem;
      color: var(--pix-neutral-700);
    }
  </style>
</template>
```

## Switch désactivé

`@isDisabled` empêche de modifier le switch sans le retirer du flux de lecture : il reste annoncé par les lecteurs d'écran.
Accompagnez-le toujours d'une explication visible de la raison du blocage.

```gjs live nebulix
import { PixSwitch } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-disabled">
    <PixSwitch @id="disabled-off" @isDisabled={{true}} />
    <PixSwitch @id="disabled-on" @checked={{true}} @isDisabled={{true}} />
  </div>

  <style>
    .demo-disabled {
      display: flex;
      flex-direction: column;
      gap: 1rem;
    }
  </style>
</template>
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-switch'
  @name='PixSwitchSignature'
/>
```
