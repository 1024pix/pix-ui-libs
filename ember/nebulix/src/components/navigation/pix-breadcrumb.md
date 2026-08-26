---
title: PixBreadcrumb
---

# PixBreadcrumb

`PixBreadcrumb` situe la page courante dans l'arborescence du site et permet de
remonter d'un niveau.

Il n'a d'intérêt que sur des pages réellement imbriquées. Sur une application
plate, il n'apporte rien.

## Utilisation

```gjs live preview nebulix
import { PixBreadcrumb } from '@1024pix/nebulix-ember';

const chemin = [
  { label: 'Accueil', route: 'index' },
  { label: 'Campagnes', route: 'index' },
  { label: 'Compétences numériques 2024' },
];

<template><PixBreadcrumb @links={{chemin}} /></template>
```

Les maillons vont du plus général au plus précis. Le dernier décrit la page
courante : laissez-le **sans `route`**, c'est ce qui le rend non cliquable et
signale la position actuelle aux lecteurs d'écran.

Reprenez le titre de chaque page comme libellé, pour que le fil corresponde à
ce que l'utilisateur a vu en chemin.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/navigation/pix-breadcrumb'
  @name='PixBreadcrumbSignature'
/>
```
