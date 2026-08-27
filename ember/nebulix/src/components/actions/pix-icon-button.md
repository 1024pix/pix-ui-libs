---
title: PixIconButton
---

# PixIconButton

`PixIconButton` crée un bouton avec seulement une icône. Utiliser `@iconName`
et `@plainIcon` pour sélectionner l'icône à utiliser.

## Utilisation

```gjs live preview nebulix
import { PixIconButton } from '@1024pix/nebulix-ember';

const modifier = () => {
  // votre action
};

<template>
  <PixIconButton @iconName="edit" @ariaLabel="Modifier le profil" @triggerAction={{modifier}} />
</template>
```

`@ariaLabel` est **obligatoire** pour l'accessibilité de ce composant.

## Tailles

`@size` ajuste le diamètre du bouton. Par défaut : `big`.

```gjs live nebulix
import { PixIconButton } from '@1024pix/nebulix-ember';

const noop = () => {};

<template>
  <div class="demo-sizes">
    <figure>
      <PixIconButton @iconName="delete" @ariaLabel="Supprimer" @triggerAction={{noop}} />
      <figcaption>big</figcaption>
    </figure>

    <figure>
      <PixIconButton
        @iconName="delete"
        @ariaLabel="Supprimer"
        @size="small"
        @triggerAction={{noop}}
      />
      <figcaption>small</figcaption>
    </figure>

    <figure>
      <PixIconButton
        @iconName="delete"
        @ariaLabel="Supprimer"
        @size="xsmall"
        @triggerAction={{noop}}
      />
      <figcaption>xsmall</figcaption>
    </figure>
  </div>

  <style>
    .demo-sizes {
      display: flex;
      flex-wrap: wrap;
      gap: 1.5rem;
      align-items: flex-end;
    }

    .demo-sizes figure {
      display: flex;
      flex-direction: column;
      gap: 0.5rem;
      align-items: center;
      margin: 0;
    }

    .demo-sizes figcaption {
      font-family: monospace;
      font-size: 0.8rem;
      color: var(--pix-neutral-500);
    }
  </style>
</template>
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/actions/pix-icon-button'
  @name='PixIconButtonSignature'
/>
```
