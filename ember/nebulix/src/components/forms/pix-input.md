---
title: PixInput
---

# PixInput

`PixInput` permet de créer un champ de texte court: un nom, un e-mail,
un numéro. Pour un texte long, préférez `PixTextarea` et pour un mot de passe,
`PixInputPassword`.

## Utilisation

```gjs live preview nebulix
import { PixInput } from '@1024pix/nebulix-ember';

<template>
  <PixInput @id="email" type="email" placeholder="prenom.nom@example.net">
    <:label>Adresse e-mail</:label>
  </PixInput>
</template>
```

Le bloc `:label` est le seul contenu attendu. Les attributs HTML natifs
(`type`, `placeholder`, `name`, `autocomplete`, `disabled`…) se posent
directement sur le composant : ils sont transmis au champ.

## Validation

`@validationStatus` communique le résultat d'une vérification. Trois valeurs sont possibles:

- success
- error
- default

`@errorMessage` indique le message d'erreur à afficher.Celui-ci ne s'affiche que lorsque `@validationStatus="error"`. Le message est
rattaché au champ par `aria-describedby` : il est donc annoncé au lecteur
d'écran en même temps que le champ.

```gjs live preview nebulix
import { PixInput } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-stack">
    <PixInput @id="ok" @validationStatus="success" value="marie.dupont@example.net">
      <:label>Adresse e-mail</:label>
    </PixInput>

    <PixInput
      @id="ko"
      @validationStatus="error"
      @errorMessage="Cette adresse e-mail n'est pas valide."
      value="marie.dupont"
    >
      <:label>Adresse e-mail</:label>
    </PixInput>
  </div>

  <style>
    .demo-stack {
      display: flex;
      flex-direction: column;
      gap: 1.5rem;
    }
  </style>
</template>
```

## Champ obligatoire

`@requiredLabel` marque le champ d'un astérisque et pose l'attribut `required`.
Le texte fourni devient l'infobulle de l'astérisque.

```gjs live nebulix
import { PixInput } from '@1024pix/nebulix-ember';

<template>
  <PixInput
    @id="nom"
    @requiredLabel="Champ obligatoire"
    @subLabel="Tel qu'il figure sur votre pièce d'identité"
  >
    <:label>Nom de naissance</:label>
  </PixInput>
</template>
```

## Mise en page

- `@inlineLabel` place le libellé à gauche du champ.

```gjs live nebulix
import { PixInput } from '@1024pix/nebulix-ember';

<template>
  <PixInput
    @id="nom"
    @requiredLabel="Champ obligatoire"
    @subLabel="Tel qu'il figure sur votre pièce d'identité"
    @inlineLabel={{true}}
  >
    <:label>Nom de naissance</:label>
  </PixInput>
</template>
```

- `@isFullWidth` étend le champ à toute la largeur disponible dans le parent. Il est cumulable avec le mode inlineLabel.

```gjs live nebulix
import { PixInput } from '@1024pix/nebulix-ember';

<template>
  <PixInput @id="firstname-fullwidth" @requiredLabel="Champ obligatoire" @isFullWidth={{true}}>
    <:label>Prénom</:label>
  </PixInput>
</template>
```

```gjs live nebulix
import { PixInput } from '@1024pix/nebulix-ember';

<template>
  <PixInput
    @id="firstname-fullwidth-inline"
    @requiredLabel="Champ obligatoire"
    @isFullWidth={{true}}
    @inlineLabel={{true}}
  >
    <:label>Prénom</:label>
  </PixInput>
</template>
```

## Tests

Pour accéder à l'élément via son label avec `testing-library`

```gjs preview
<PixInput @id="firstName" />
  <:label>Prénom</:label>
</PixInput>
```

```gjs preview
screen.getByLabelText('Prénom');
```

Si le paramètre `@subLabel` est utilisé, il faudra concatener les valeurs du bloc `:label` et `@subLabel`

```gjs preview
<PixInput @id="firstName" @subLabel="exemple: Barry">
  <:label>Prénom</:label>
</PixInput>
```

```gjs preview
screen.getByLabelText('Prénom exemple: Barry');
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-input'
  @name='PixInputSignature'
/>
```
