---
title: PixIconButton
---

# PixIconButton

`PixIconButton` déclenche une action représentée par une seule icône, sans
libellé visible : fermer, modifier, supprimer une ligne.

Réservez-le aux actions dont l'icône est universellement comprise, ou qui se
répètent dans une liste où le texte alourdirait la lecture. Dans le doute,
`PixButton` avec `@iconBefore` reste plus clair.

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

`@ariaLabel` est **obligatoire** : c'est le seul nom dont dispose le bouton pour
les lecteurs d'écran. Décrivez l'action et son objet — « Modifier le profil »,
pas « Modifier ». Il est également affiché en infobulle par certains
navigateurs.

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
      align-items: flex-start;
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

Attention à la cible de clic : en `xsmall`, le bouton descend sous la taille
minimale recommandée pour un usage tactile. Ne l'employez pas sur un écran
destiné au mobile.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/actions/pix-icon-button'
  @name='PixIconButtonSignature'
/>
```
