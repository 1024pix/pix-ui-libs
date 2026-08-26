---
title: PixButtonUpload
---

# PixButtonUpload

`PixButtonUpload` ouvre le sélecteur de fichiers du système. Il a l'apparence
d'un `PixButton`, mais rend en réalité un libellé associé à un champ de type
`file` masqué — ce montage préserve le comportement natif et l'accessibilité au
clavier.

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

## Écrire le libellé

Le libellé doit nommer ce qu'on importe, pas l'opération technique :
« Importer la liste des élèves » plutôt que « Parcourir » ou « Choisir un
fichier ». Indiquez à côté les formats et la taille acceptés : c'est
l'information qui manque le plus souvent au moment du choix.

## Après la sélection

Le composant se contente de transmettre les fichiers : il n'affiche ni leur nom,
ni la progression, ni les erreurs. C'est à votre écran de confirmer ce qui a été
retenu, faute de quoi l'utilisateur reste sans retour après avoir choisi son
fichier.

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
