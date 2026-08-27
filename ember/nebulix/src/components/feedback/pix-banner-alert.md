---
title: PixBannerAlert
---

# PixBannerAlert

`PixBannerAlert` annonce en tête d'application une information qui concerne
tout le monde : une maintenance programmée, une nouveauté, l'environnement sur
lequel on travaille.

Il occupe toute la largeur et s'impose à chaque page. Réservez-le à ce qui
justifie cette place ; un message propre à un écran relève de
`PixNotificationAlert`.

## Utilisation

```gjs live preview nebulix
import { PixBannerAlert } from '@1024pix/nebulix-ember';

<template>
  <PixBannerAlert @type="information">
    Une maintenance est prévue le samedi 12 avril de 8 h à 10 h.
  </PixBannerAlert>
</template>
```

Le bandeau porte `role="alert"` : les lecteurs d'écran l'annoncent dès son
apparition, en interrompant la lecture en cours. C'est une raison de plus de ne
pas en abuser.

## Types

```gjs live nebulix
import { PixBannerAlert } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-banners">
    <PixBannerAlert @type="information">
      Une maintenance est prévue le samedi 12 avril de 8 h à 10 h.
    </PixBannerAlert>

    <PixBannerAlert @type="warning">
      La campagne se termine dans deux jours.
    </PixBannerAlert>

    <PixBannerAlert @type="error">
      L'envoi des résultats est momentanément indisponible.
    </PixBannerAlert>

    <PixBannerAlert @type="communication">
      Découvrez le nouveau parcours de rentrée.
    </PixBannerAlert>

    <PixBannerAlert @type="environment">
      Vous êtes sur l'environnement de recette.
    </PixBannerAlert>
  </div>

  <style>
    .demo-banners {
      display: flex;
      flex-direction: column;
      gap: 1rem;
    }
  </style>
</template>
```

| Type            | Ce qu'il exprime                                     |
| --------------- | ---------------------------------------------------- |
| `information`   | Un fait utile à connaître. Type par défaut.          |
| `warning`       | Une échéance ou une restriction à anticiper.         |
| `error`         | Un incident en cours qui affecte le service.         |
| `communication` | Une annonce éditoriale, une nouveauté.               |
| `environment`   | Un rappel technique : vous n'êtes pas en production. |

`communication-orga` et `communication-certif` déclinent l'annonce éditoriale
aux couleurs de Pix Orga et Pix Certif.

## Lien d'action

`@actionLabel` et `@actionUrl` ajoutent un lien au bandeau. Les deux sont
nécessaires : l'un sans l'autre n'affiche rien.

La destination est interprétée d'après sa forme : une valeur contenant une
barre oblique est traitée comme une URL externe et ouverte dans un nouvel
onglet ; sinon, elle est traitée comme un nom de route de votre application.

```gjs live nebulix
import { PixBannerAlert } from '@1024pix/nebulix-ember';

<template>
  <PixBannerAlert
    @type="communication"
    @actionLabel="Découvrir la nouveauté"
    @actionUrl="https://pix.fr/actualites"
  >
    Le nouveau parcours de rentrée est disponible.
  </PixBannerAlert>
</template>
```

## Bandeau fermable

`@canCloseBanner` ajoute un bouton de fermeture, et
`@onCloseBannerTriggerAction` est appelée juste avant la disparition — c'est là
que vous mémorisez le choix de l'utilisateur, faute de quoi le bandeau
réapparaîtra à la page suivante.

Rendez fermable tout bandeau que l'utilisateur a intérêt à écarter une fois lu.
Un bandeau `environment`, lui, doit rester visible.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/feedback/pix-banner-alert'
  @name='PixBannerAlertSignature'
/>
```
