---
title: PixButtonLink
---

# PixButtonLink

`PixButtonLink` a l'apparence d'un `PixButton` mais emmène l'utilisateur
ailleurs : une autre page, un site externe, un document.

Le choix entre les deux ne tient pas au style mais à ce qui se passe au clic :
si l'URL change, c'est un lien ; si la page réagit sur place, c'est un bouton.
Cette distinction est ce qui permet d'ouvrir la destination dans un nouvel
onglet et aux lecteurs d'écran de l'annoncer comme un lien.

## Naviguer dans l'application

`@route` rend un `<LinkTo>` : la navigation reste interne à l'application, sans
rechargement.

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
empiler une nouvelle — utile après une étape que l'utilisateur ne doit pas
revivre en revenant en arrière.

## Pointer vers l'extérieur

Sans `@route`, `@href` rend un `<a>` classique.

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

Quand le lien ouvre un nouvel onglet, annoncez-le : une icône `openNew` et un
libellé explicite évitent à l'utilisateur d'être dérouté.

## Variantes et tailles

`@variant`, `@size`, `@iconBefore` et `@iconAfter` se comportent exactement comme
sur `PixButton`. Reportez-vous à sa page pour choisir la variante.

## Lien inactif

`@isDisabled` neutralise le lien. Préférez toutefois masquer un lien qui n'a pas
lieu d'être plutôt que de l'afficher inactif sans explication.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/actions/pix-button-link'
  @name='PixButtonLinkSignature'
/>
```
