---
title: PixButton
---

# PixButton

`PixButton` rend un élément `<button>` natif avec un `type=button` par defaut.

## Utilisation

```gjs live preview nebulix
import { PixButton } from '@1024pix/nebulix-ember';

const enregistrer = () => {
  // votre action
};

<template>
  <PixButton @triggerAction={{enregistrer}}>
    Enregistrer
  </PixButton>
</template>
```

`@triggerAction` est obligatoire, sauf si le bouton porte `@type="submit"`.

### Icônes

Il est possible de rajouter une icône avant `@iconBefore` ou après `@iconAfter`
(ou les deux !). On peut spécifier la version **plain** de l'icône avec
les proprités `@plainIconBefore` ou `@plainIconAfter` (ou les deux).

```gjs live nebulix
import { PixButton } from '@1024pix/nebulix-ember';
const noop = () => {};
<template>
  <PixButton @triggerAction={{noop}} @iconBefore="brick" @plainIconBefore="true" @iconAfter="brick">
    Construire</PixButton>
</template>
```

> Accessibilité : dans le cas où les icônes ont une valeur d'information
> (ex: un bouton ⬅️ Précédent), il est important d'apporter un aria-label au
> bouton (ex: "Retour à la page précédente").

## Variantes

`@variant` définit le rôle du bouton dans la page, pas seulement sa couleur.
Par défaut : `primary`.

```gjs live nebulix
import { PixButton } from '@1024pix/nebulix-ember';

const noop = () => {};

<template>
  <div class="demo-variants">
    <figure>
      <PixButton @triggerAction={{noop}}>Enregistrer</PixButton>
      <figcaption>primary</figcaption>
    </figure>

    <figure>
      <PixButton @variant="primary-bis" @triggerAction={{noop}}>Enregistrer</PixButton>
      <figcaption>primary-bis</figcaption>
    </figure>

    <figure>
      <PixButton @variant="secondary" @triggerAction={{noop}}>Annuler</PixButton>
      <figcaption>secondary</figcaption>
    </figure>

    <figure>
      <PixButton @variant="tertiary" @triggerAction={{noop}}>En savoir plus</PixButton>
      <figcaption>tertiary</figcaption>
    </figure>

    <figure>
      <PixButton @variant="success" @triggerAction={{noop}}>Valider l'inscription</PixButton>
      <figcaption>success</figcaption>
    </figure>

    <figure>
      <PixButton @variant="error" @triggerAction={{noop}}>Supprimer le compte</PixButton>
      <figcaption>error</figcaption>
    </figure>
  </div>

  <style>
    .demo-variants {
      display: flex;
      flex-wrap: wrap;
      gap: 1.5rem;
      align-items: flex-start;
    }

    .demo-variants figure {
      display: flex;
      flex-direction: column;
      gap: 0.5rem;
      align-items: center;
      margin: 0;
    }

    .demo-variants figcaption {
      font-family: monospace;
      font-size: 0.8rem;
      color: var(--pix-neutral-500);
    }
  </style>
</template>
```

| Variante      | Quand l'utiliser                                                                |
| ------------- | ------------------------------------------------------------------------------- |
| `primary`     | L'action principale attendue de l'utilisateur. Une seule par page.              |
| `primary-bis` | Une action principale sur un fond où `primary` manque de contraste.             |
| `secondary`   | Une action alternative, présentée à côté de l'action principale.                |
| `tertiary`    | Une action accessoire, de faible importance visuelle.                           |
| `success`     | Une action qui confirme ou valide définitivement.                               |
| `error`       | Une action **destructrice ou irréversible** : supprimer, révoquer, désinscrire. |

### Sur fond sombre

Les variantes `primary-white`, `secondary-white` et `tertiary-white` sont conçues
pour les fonds sombres ou colorés. `transparent-dark` complète la série pour un
bouton sans fond, dont `@isBorderVisible` fait apparaître la bordure.

```gjs live nebulix
import { PixButton } from '@1024pix/nebulix-ember';

const noop = () => {};

<template>
  <div class="demo-dark">
    <figure>
      <PixButton @variant="primary-white" @triggerAction={{noop}}>Commencer</PixButton>
      <figcaption>primary-white</figcaption>
    </figure>

    <figure>
      <PixButton @variant="secondary-white" @triggerAction={{noop}}>Annuler</PixButton>
      <figcaption>secondary-white</figcaption>
    </figure>

    <figure>
      <PixButton @variant="tertiary-white" @triggerAction={{noop}}>En savoir plus</PixButton>
      <figcaption>tertiary-white</figcaption>
    </figure>

    <figure>
      <PixButton
        @variant="transparent-dark"
        @isBorderVisible={{true}}
        @triggerAction={{noop}}
      >Continuer</PixButton>
      <figcaption>transparent-dark</figcaption>
    </figure>
  </div>

  <style>
    .demo-dark {
      display: flex;
      flex-wrap: wrap;
      gap: 1.5rem;
      align-items: flex-start;
      padding: 1.5rem;
      background-color: var(--pix-primary-500);
      border-radius: 8px;
    }

    .demo-dark figure {
      display: flex;
      flex-direction: column;
      gap: 0.5rem;
      align-items: center;
      margin: 0;
    }

    .demo-dark figcaption {
      font-family: monospace;
      font-size: 0.8rem;
      color: var(--pix-neutral-0);
    }
  </style>
</template>
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/actions/pix-button'
  @name='PixButtonSignature'
/>
```
