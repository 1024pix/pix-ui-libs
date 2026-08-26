---
title: PixInput
---

# PixInput

`PixInput` recueille une saisie courte sur une seule ligne : un nom, un e-mail,
un numéro. Pour un texte long, préférez `PixTextarea` ; pour un mot de passe,
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

`@validationStatus` communique le résultat d'une vérification. Ne l'affichez
qu'après une tentative de l'utilisateur, jamais pendant la frappe.

```gjs live nebulix
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

| Statut    | Ce qu'il dit à l'utilisateur                                   |
| --------- | -------------------------------------------------------------- |
| `default` | Rien n'a encore été vérifié.                                   |
| `success` | La saisie est valide. À réserver aux cas où le doute est réel. |
| `error`   | La saisie doit être corrigée avant de continuer.               |

`@errorMessage` n'a d'effet qu'avec `@validationStatus="error"`. Écrivez-y ce
qu'il faut faire pour corriger, pas seulement ce qui ne va pas. Le message est
rattaché au champ par `aria-describedby` : il est donc annoncé au lecteur
d'écran en même temps que le champ.

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

`@inlineLabel` place le libellé à gauche du champ plutôt qu'au-dessus, et
`@isFullWidth` étend le champ à toute la largeur disponible.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-input'
  @name='PixInputSignature'
/>
```
