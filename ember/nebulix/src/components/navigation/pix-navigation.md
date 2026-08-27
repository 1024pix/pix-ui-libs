---
title: PixNavigation
---

# PixNavigation

`PixNavigation` est le menu latéral d'une application Pix. Il réunit la marque,
les entrées de navigation et un pied de menu, et se replie en menu burger sur
petit écran.

Il s'installe dans le bloc `:navigation` de `PixAppLayout`.

## Utilisation

```gjs live preview nebulix
import { PixNavigation, PixNavigationButton, PixNavigationSeparator } from '@1024pix/nebulix-ember';

<template>
  <PixNavigation
    @openLabel="Ouvrir le menu"
    @closeLabel="Fermer le menu"
    @navigationAriaLabel="Navigation principale"
  >
    <:brand>Pix Orga</:brand>

    <:navElements>
      <PixNavigationButton @route="index" @icon="users">Participants</PixNavigationButton>
      <PixNavigationButton @route="index" @icon="campaign">Campagnes</PixNavigationButton>
      <PixNavigationSeparator />
      <PixNavigationButton @route="index" @icon="settings">Paramètres</PixNavigationButton>
    </:navElements>

    <:footer>
      <PixNavigationButton @route="index" @icon="logout">Se déconnecter</PixNavigationButton>
    </:footer>
  </PixNavigation>
</template>
```

`@openLabel` et `@closeLabel` sont **obligatoires** : ils nomment le bouton du
menu burger, qui n'a pas de texte visible. Renseignez également
`@navigationAriaLabel` dès que la page compte plusieurs navigations.

## Les entrées

`PixNavigationButton` est une entrée de menu. Avec `@route`, l'entrée
correspondant à la page affichée est mise en avant automatiquement — vous
n'avez pas d'état actif à gérer.

Donnez à chaque entrée un `@icon` : c'est tout ce qui subsiste une fois la
navigation repliée.

`PixNavigationSeparator` trace un filet entre deux familles d'entrées. Il n'a
aucun argument.

Le menu se referme de lui-même à chaque changement de page sur mobile.

## Navigation repliable

Le bouton de repli n'apparaît que si le service `shrinkNavigationService`
l'autorise — ce qu'active `PixAppLayout` avec `@variant="admin"`. Une fois
replié, le menu ne montre plus que les icônes, chacune accompagnée d'une
infobulle au survol et au focus.

## API Docs

### PixNavigation

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/navigation/pix-navigation'
  @name='PixNavigationSignature'
/>
```

### PixNavigationButton

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/navigation/pix-navigation-button'
  @name='PixNavigationButtonSignature'
/>
```

### PixNavigationSeparator

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/navigation/pix-navigation-separator'
  @name='PixNavigationSeparatorSignature'
/>
```
