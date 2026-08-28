---
title: PixBannerAlert
---

# PixBannerAlert

`PixBannerAlert` permet de mettre en avant une information importante.

> Il est possible de surcharger le style d'une `<PixBannerAlert>` via l'attribut
> class ainsi que de passer n'importe quel attribut sur sa div wrapper
> (par exemple, un aria-label)

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
apparition, en interrompant la lecture en cours.

## Types

Il existe différent type de bannière :

```gjs live nebulix
import { PixBannerAlert } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-banners">
    <figure>
      <figcaption class="pix-body-xs"><pre>@type="information"</pre></figcaption>
      <PixBannerAlert @type="information">
        Une maintenance est prévue le samedi 12 avril de 8 h à 10 h.
      </PixBannerAlert>
    </figure>
    <figure>
      <figcaption class="pix-body-xs"><pre>@type="warning"</pre></figcaption>
      <PixBannerAlert @type="warning">
        La campagne se termine dans deux jours.
      </PixBannerAlert>
    </figure>
    <figure>
      <figcaption class="pix-body-xs"><pre>@type="error"</pre></figcaption>
      <PixBannerAlert @type="error">
        L'envoi des résultats est momentanément indisponible.
      </PixBannerAlert>
    </figure>
    <figure>
      <figcaption class="pix-body-xs"><pre>@type="environment"</pre></figcaption>
      <PixBannerAlert @type="environment">
        Découvrez le nouveau parcours de rentrée.
      </PixBannerAlert>
    </figure>
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

## Bandeau avec un lien

Pour rajouter un lien interne à une application, il faudra definir deux propriétés:

- `@actionLabel` qui permet de définir le libellé du lien.
- `@actionUrl` qui contiendra soit le nom d'une route pour un lien interne,
  soit une url pour un lien externe.

```gjs live nebulix
import { PixBannerAlert } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-banners">
    <PixBannerAlert @type="information" @actionLabel="Voir l'accueil" @actionUrl="index">
      Une maintenance est prévue le samedi 12 avril de 8 h à 10 h.
    </PixBannerAlert>

    <PixBannerAlert
      @type="environment"
      @actionLabel="Découvrir la nouveauté"
      @actionUrl="https://pix.fr/actualites"
    >
      Le nouveau parcours de rentrée est disponible.
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

## Bandeau fermable

`@canCloseBanner` ajoute un bouton de fermeture, et
`@onCloseBannerTriggerAction` est appelée juste avant la disparition

Rendez fermable tout bandeau que l'utilisateur a intérêt à écarter une fois lu.
Un bandeau `environment`, lui, doit rester visible.

```gjs live nebulix
import { PixBannerAlert, PixToastContainer } from '@1024pix/nebulix-ember';

import Component from '@glimmer/component';
import { service } from '@ember/service';

export default class BannerDemo extends Component {
  @service pixToast;

  fermer = () => {
    this.pixToast.sendInformationNotification({ message: 'Le bandeau est fermé' });
  };

  <template>
    <PixBannerAlert
      @type="warning"
      @canCloseBanner="true"
      @onCloseBannerTriggerAction={{this.fermer}}
    >
      Une maintenance est prévue le samedi 12 avril de 8 h à 10 h.
    </PixBannerAlert>
    <PixToastContainer @closeButtonAriaLabel="Fermer la notification" />
  </template>
}
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/feedback/pix-banner-alert'
  @name='PixBannerAlertSignature'
/>
```
