---
title: PixTooltip
---

# PixTooltip

`PixTooltip` affiche une précision au survol ou au focus d'un élément : le sens
d'une icône, le détail d'un calcul, un intitulé tronqué.

L'infobulle est un complément, jamais le seul support d'une information : elle
ne s'affiche pas au toucher, et disparaît dès que le pointeur s'éloigne. Ce qui
est indispensable doit rester visible dans la page.

## Utilisation

```gjs live preview nebulix
import { PixIcon, PixTooltip } from '@1024pix/nebulix-ember';

<template>
  <PixTooltip @id="infobulle-participants">
    <:triggerElement>
      <PixIcon
        @name="info"
        @plainIcon={{true}}
        aria-label="En savoir plus sur les participants"
        aria-describedby="infobulle-participants"
      />
    </:triggerElement>
    <:tooltip>
      Un participant est une personne ayant commencé le parcours.
    </:tooltip>
  </PixTooltip>
</template>
```

Les deux blocs sont attendus : `:triggerElement` porte l'élément déclencheur,
`:tooltip` le texte affiché.

`@id` doit être repris dans l'`aria-describedby` du déclencheur : c'est ce lien
qui fait annoncer l'infobulle par les lecteurs d'écran. Sans lui, le texte leur
reste invisible.

Le composant rend le déclencheur accessible au clavier de lui-même. Si celui-ci
l'est déjà — un bouton, un lien — indiquez-le avec
`@isTriggerElementFocusable={{true}}`, pour éviter un arrêt de tabulation en
double.

## Position

`@position` place l'infobulle par rapport au déclencheur : `top` par défaut,
ainsi que `right`, `bottom`, `left` et leurs déclinaisons `top-left`,
`top-right`, `bottom-left` et `bottom-right`.

Choisissez le côté où l'infobulle ne masquera pas ce que l'utilisateur regarde,
et ne sortira pas de l'écran.

```gjs live nebulix
import { PixIcon, PixTooltip } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-tooltips">
    <PixTooltip @id="ib-droite" @position="right">
      <:triggerElement>
        <PixIcon @name="info" @plainIcon={{true}} aria-describedby="ib-droite" />
      </:triggerElement>
      <:tooltip>Affichée à droite</:tooltip>
    </PixTooltip>

    <PixTooltip @id="ib-bas" @position="bottom">
      <:triggerElement>
        <PixIcon @name="info" @plainIcon={{true}} aria-describedby="ib-bas" />
      </:triggerElement>
      <:tooltip>Affichée en dessous</:tooltip>
    </PixTooltip>
  </div>

  <style>
    .demo-tooltips {
      display: flex;
      gap: 4rem;
      padding: 2rem;
    }
  </style>
</template>
```

## Apparence

`@isWide` élargit l'infobulle pour un texte de plusieurs lignes, `@isLight`
applique le fond clair, et `@isInline` l'aligne sur un déclencheur placé au fil
du texte.

`@hide` empêche l'affichage sans retirer le composant : utile quand l'infobulle
n'a plus lieu d'être, par exemple parce que le texte qu'elle complète n'est
plus tronqué.

Gardez le texte à une phrase. Au-delà, c'est du contenu de page.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/overlay/pix-tooltip'
  @name='PixTooltipSignature'
/>
```
