---
title: PixAppLayout
---

# PixAppLayout

`PixAppLayout` pose la structure d'une application Pix : un bandeau en haut, la
navigation à gauche, le contenu au centre et un pied de page. Il gère les
positions et les décalages, notamment celui que provoque l'apparition d'un
bandeau.

Il s'utilise une seule fois, à la racine de l'application.

## Utilisation

```gjs live preview nebulix
import {
  PixAppLayout,
  PixBannerAlert,
  PixNavigation,
  PixNavigationButton,
} from '@1024pix/nebulix-ember';

<template>
  <PixAppLayout @variant="orga">
    <:banner>
      <PixBannerAlert @type="information">
        Une maintenance est prévue samedi de 8 h à 10 h.
      </PixBannerAlert>
    </:banner>

    <:navigation>
      <PixNavigation @openLabel="Ouvrir le menu" @closeLabel="Fermer le menu">
        <:brand>Pix Orga</:brand>
        <:navElements>
          <PixNavigationButton @route="index" @icon="users">Participants</PixNavigationButton>
          <PixNavigationButton @route="index" @icon="campaign">Campagnes</PixNavigationButton>
        </:navElements>
        <:footer>
          <PixNavigationButton @route="index" @icon="logout">Se déconnecter</PixNavigationButton>
        </:footer>
      </PixNavigation>
    </:navigation>

    <:main>
      <h1>Campagnes</h1>
      <p>Le contenu de la page vient ici.</p>
    </:main>

    <:footer>
      <p>Pix — Service public d'évaluation des compétences numériques</p>
    </:footer>
  </PixAppLayout>
</template>
```

Les quatre blocs sont indépendants : laissez `:banner` ou `:footer` vides si
vous n'en avez pas l'usage.

`:main` doit contenir le `<h1>` de la page. Le composant ne produit aucun
titre : la hiérarchie reste entièrement à votre charge.

## Variantes

`@variant` accorde la mise en page aux couleurs de l'application : `primary`,
`orga`, `certif`, `admin` ou `modulix`.

`admin` a un effet supplémentaire : elle active le bouton qui permet de replier
la navigation en une colonne d'icônes.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/navigation/pix-app-layout'
  @name='PixAppLayoutSignature'
/>
```
