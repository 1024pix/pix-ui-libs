---
title: PixButtonUpload
---

# PixButtonUpload

`PixButtonUpload` ouvre le sélecteur de fichiers du système. Il a l'apparence
d'un `PixButton` et reprends les propriétés `@size` `@variant` et `@isBorderVisible`
du `PixButton`.

## Utilisation

```gjs live preview nebulix
import { PixButtonUpload } from '@1024pix/nebulix-ember';

const importer = () => {
  // votre action
};

<template>
  <PixButtonUpload @id="import-eleves" @onChange={{importer}} accept=".csv">
    Importer la liste des élèves
  </PixButtonUpload>
</template>
```

`@id` et `@onChange` sont obligatoires. `@id` relie le libellé au champ : sans
lui, le clic reste sans effet. `@onChange` reçoit la `FileList` sélectionnée.

Les attributs du champ natif — `accept`, `multiple`, `disabled` — se posent
directement sur le composant.

## Variantes et tailles

`@variant` et `@size` se comportent comme sur `PixButton`.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/actions/pix-button-upload'
  @name='PixButtonUploadSignature'
/>
```
