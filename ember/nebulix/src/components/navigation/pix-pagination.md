---
title: PixPagination
---

# PixPagination

`PixPagination` affiche la pagination dans une liste d'éléments. Il indique
où l'on en est, permet d'avancer et de reculer, et de choisir le nombre
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

const texts = {
  title: 'Voir',
  pageSize: "Nombre d'élément à afficher par page",
  pageElementCount: '26-50 sur 138 éléments',
  previousPage: 'Aller à la page précédente',
  pageNumber: 'Page 2 / 6',
  nextPage: 'Aller à la page suivante',
};

<template><PixPagination @pagination={{pagination}} @texts={{texts}} /></template>
```

`@pagination` décrit l'état courant : la page affichée, la taille de page, le
nombre de pages et le nombre total de résultats.

`@texts` fournit tous les libellés affichés par le composant — « 26-50 sur 138
éléments », « Page 2 / 6 », les libellés accessibles des boutons de
navigation. Nebulix ne traduit rien lui-même : c'est à l'application
consommatrice de fournir ces textes, déjà traduits et déjà calculés (y
compris le pluriel de `pageElementCount`).

## Le composant pilote l'URL

Changer de page ou de taille de page met à jour les paramètres `pageNumber` et
`pageSize` de la route courante. Votre route doit donc déclarer ces deux
paramètres et recharger ses données quand ils changent — sans quoi rien ne se
passera.

`@onChange` est appelée après chaque changement, pour ce que l'URL ne fait pas :
remonter en haut de la liste, redemander les données au serveur.

Pour utiliser ce composant, il est recommandé de rajouter

```hbs
queryParams = { pageNumber: { refreshModel: true }, pageSize: { refreshModel: true } };
```

dans les routes où le composant `<PixPagination` est utilisée.

> Le paramètre pageOptions n'est pas requis et possède une valeur par défaut.

Sur mobile, le select qui permet de choisir le nombre d'élément à afficher sur la page est retiré.

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
