---
title: PixTabs
---

# PixTabs

`PixTabs` répartit le contenu d'une section entre plusieurs vues, chacune
associée à une URL. Il rend une navigation : cliquer sur un onglet change de
page.

Il ne convient donc pas pour basculer entre deux affichages d'une même page —
c'est le rôle de `PixSegmentedControl`.

## Utilisation

```gjs live preview nebulix
import { PixTabs } from '@1024pix/nebulix-ember';
import { LinkTo } from '@ember/routing';

<template>
  <PixTabs @ariaLabel="Sections de la campagne">
    <LinkTo @route="index">Participants</LinkTo>
    <LinkTo @route="index">Résultats</LinkTo>
    <LinkTo @route="index">Paramètres</LinkTo>
  </PixTabs>
</template>
```

Les onglets sont des `<LinkTo>` que vous fournissez : l'onglet actif est
déterminé par la route courante, sans travail de votre part.

`@ariaLabel` est **obligatoire** : il nomme cette navigation pour les lecteurs
d'écran, qui la distinguent ainsi du menu principal. Décrivez ce que les
onglets découpent — « Sections de la campagne » plutôt que « Onglets ».

Gardez les libellés à un ou deux mots, et n'excédez pas cinq onglets : au-delà,
la barre déborde et le découpage mérite d'être repensé.

## Variantes

`@variant` accorde les onglets aux couleurs de l'application : `primary`,
`orga` ou `certif`.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/navigation/pix-tabs'
  @name='PixTabsSignature'
/>
```
