---
title: PixPagination
---

# PixPagination

`PixPagination` découpe une longue liste en pages et se place sous elle. Il
indique où l'on en est, permet d'avancer et de reculer, et de choisir le nombre
de résultats affichés.

## Utilisation

```gjs live preview nebulix
import { PixPagination } from '@1024pix/nebulix-ember';

const pagination = {
  page: 2,
  pageSize: 25,
  pageCount: 6,
  rowCount: 138,
};

<template><PixPagination @pagination={{pagination}} /></template>
```

`@pagination` décrit l'état courant : la page affichée, la taille de page, le
nombre de pages et le nombre total de résultats. Le composant en déduit tous
ses libellés — « 26-50 sur 138 », « Page 2 / 6 » — dans la langue indiquée par
`@locale`.

## Le composant pilote l'URL

Changer de page ou de taille de page met à jour les paramètres `pageNumber` et
`pageSize` de la route courante. Votre route doit donc déclarer ces deux
paramètres et recharger ses données quand ils changent — sans quoi rien ne se
passera.

`@onChange` est appelée après chaque changement, pour ce que l'URL ne fait pas :
remonter en haut de la liste, redemander les données au serveur.

## Tailles de page

Par défaut, l'utilisateur choisit entre 10, 25, 50 et 100 résultats.
`@pageOptions` remplace cette liste.

`@isCondensed` affiche la version compacte, adaptée à un tableau inséré dans
une carte.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/navigation/pix-pagination'
  @name='PixPaginationSignature'
/>
```
