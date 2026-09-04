---
title: PixCode
---

# PixCode

`PixCode` recueille un code d'une longueur connue à l'avance(un code
d'accès, un identifiant de session) dans un champ unique dont la largeur
s'ajuste au nombre de caractères attendus.

## Utilisation

```gjs live preview nebulix
import { PixCode } from '@1024pix/nebulix-ember';

<template>
  <PixCode @id="code-session" @length={{6}}>
    <:label>Code de session</:label>
  </PixCode>
</template>
```

- `@length` est obligatoire : il fixe la largeur du champ ainsi que le nombre de
  caractères minimum et maximum acceptés.

## PixCode ou PixInputCode ?

Les deux composants recueillent un code de longueur fixe, mais pas de la même
manière.

| Composant      | Ce qu'il affiche       | À privilégier quand                                                     |
| -------------- | ---------------------- | ----------------------------------------------------------------------- |
| `PixCode`      | Un champ unique        | Le code est copié-collé, ou saisi au milieu d'un formulaire plus large. |
| `PixInputCode` | Une case par caractère | La saisie du code est l'unique action de l'écran.                       |

## Erreur

`@validationStatus="error"` accompagné de `@errorMessage` signale un code
refusé. Le message est rattaché au champ pour les lecteurs d'écran.

```gjs live preview nebulix
import { PixCode } from '@1024pix/nebulix-ember';

<template>
  <PixCode
    @id="code-erreur"
    @length={{6}}
    @validationStatus="error"
    @errorMessage="Ce code ne correspond à aucune session."
    value="A1B2C3"
  >
    <:label>Code de session</:label>
  </PixCode>
</template>
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-code'
  @name='PixCodeSignature'
/>
```
