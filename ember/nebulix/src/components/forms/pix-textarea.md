---
title: PixTextarea
---

# PixTextarea

`PixTextarea` recueille un texte libre de plusieurs lignes : un commentaire, une
description, un motif. Pour une saisie courte tenant sur une ligne, utilisez
plutôt `PixInput`.

## Utilisation

```gjs live preview nebulix
import { PixTextarea } from '@1024pix/nebulix-ember';

<template>
  <PixTextarea @id="motif" rows="4">
    <:label>Motif de la demande</:label>
  </PixTextarea>
</template>
```

Les attributs HTML natifs (`rows`, `placeholder`, `name`, `disabled`…) se posent
directement sur le composant.

## Limiter la longueur

`@maxlength` empêche de dépasser le nombre de caractères indiqué et affiche un
compteur sous le champ. Ne l'utilisez que si la limite est une vraie contrainte
métier : un compteur qui n'a jamais de raison d'être atteint met une pression
inutile sur l'utilisateur.

```gjs live nebulix
import { PixTextarea } from '@1024pix/nebulix-ember';

<template>
  <PixTextarea @id="bio" @maxlength={{280}} rows="3">
    <:label>Présentation</:label>
  </PixTextarea>
</template>
```

## Erreur

`@errorMessage` affiche un message sous le champ et lui applique le style
d'erreur. Écrivez-y ce qu'il faut faire pour corriger.

```gjs live nebulix
import { PixTextarea } from '@1024pix/nebulix-ember';

<template>
  <PixTextarea
    @id="motif-erreur"
    @errorMessage="Précisez votre motif en 20 caractères minimum."
    rows="3"
  >
    <:label>Motif de la demande</:label>
  </PixTextarea>
</template>
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-textarea'
  @name='PixTextareaSignature'
/>
```
