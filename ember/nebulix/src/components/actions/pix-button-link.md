---
title: PixButtonLink
---

# PixButtonLink

`PixButtonLink` est un lien html avec l'apparence d'un `PixButton`.
Il reprend le même API que le `PixButton`.

## Utilisation avec un `@route`

L'utilisation de `@route` rend un `<LinkTo>` : la navigation reste interne à
l'application, sans rechargement.

```gjs live preview nebulix
import { PixButtonLink } from '@1024pix/nebulix-ember';

<template>
  <PixButtonLink @route="index">
    Retour à l'accueil
  </PixButtonLink>
</template>
```

`@model` transmet un modèle à la route, `@query` ajoute des paramètres à l'URL,
et `@replace` remplace l'entrée courante de l'historique plutôt que d'en
empiler une nouvelle.

## Utilisation avec un `@href`

Le composant rend un `<a>` classique. On peut lui passer tout les attributs
d'un lien classique. Ils seront transmis à la balise `a`.

```gjs live nebulix
import { PixButtonLink } from '@1024pix/nebulix-ember';

<template>
  <PixButtonLink
    @href="https://pix.fr"
    @variant="secondary"
    @iconAfter="openNew"
    target="_blank"
    rel="noopener noreferrer"
  >
    Consulter le site Pix
  </PixButtonLink>
</template>
```

Quand le lien pointe sur une adresse en dehors de l'application, une icône `openNew`
est ajouté automatiquement. Il faut toutefois indiquer dans un `title`
l'ouverture d'une nouvelle fenêtre.

## Variantes et tailles

`@variant`, `@size`, `@iconBefore` et `@iconAfter` se comportent exactement comme
sur `PixButton`. Reportez-vous à [sa page](./pix-button.md) pour choisir la variante.

> **Accessibilité** : dans le cas où les icônes ont une valeur d'information
> (ex: un bouton ⬅️ Précédent), il est important d'apporter un aria-label au
> bouton (ex: "Retour à la page précédente").

## Lien inactif

`@isDisabled` neutralise le lien. Préférez toutefois masquer un lien qui n'a pas
lieu d'être plutôt que de l'afficher inactif sans explication.

> Attention : La neutralisation du lien ne marche que pour des liens internes
> qui utilise `@route`

```gjs live nebulix
import { PixButtonLink } from '@1024pix/nebulix-ember';

<template>
  <div>
    <PixButtonLink @route="index" @variant="secondary" @isDisabled="true">
      Index
    </PixButtonLink>
  </div>
</template>
```

## Bordures

`@isBorderVisible` ne doit être utilisé seulement quand le `@variant` est `secondary`
ou `transparent-dark` boolean.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/actions/pix-button-link'
  @name='PixButtonLinkSignature'
/>
```
