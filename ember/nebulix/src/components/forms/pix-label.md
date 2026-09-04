---
title: PixLabel
---

# PixLabel

`PixLabel` intitule un champ de formulaire. Tous les composants de saisie de
Nebulix en embarquent déjà un via leur bloc `:label` : n'utilisez `PixLabel`
directement que pour intituler un champ que vous construisez vous-même, ou un
groupe de champs.

## Utilisation

```gjs live preview nebulix
import { PixLabel } from '@1024pix/nebulix-ember';

<template>
  <PixLabel @for="mon-champ">Nom de l'établissement</PixLabel>
  <input id="mon-champ" type="text" />
</template>
```

`@for` doit reprendre l'identifiant du champ : c'est ce lien qui permet au
lecteur d'écran d'annoncer le bon libellé, et au clic sur le texte de placer le
curseur dans le champ.

## Champ obligatoire et complément d'information

`@requiredLabel` ajoute un astérisque au libellé. Le texte que vous passez
devient son infobulle : écrivez-y ce que l'astérisque signifie, pas le mot
« obligatoire » seul.

`@subLabel` accueille une précision utile à la saisie — un format attendu, un
exemple. Réservez-le à ce qui aide à remplir le champ.

```gjs live preview nebulix
import { PixLabel } from '@1024pix/nebulix-ember';

<template>
  <PixLabel
    @for="mon-siret"
    @requiredLabel="Champ obligatoire"
    @subLabel="14 chiffres, sans espace"
  >
    Numéro SIRET
  </PixLabel>
  <input id="mon-siret" type="text" />
</template>
```

## Intituler un groupe de champs

Avec `@useAsLegend`, `PixLabel` rend une balise `<legend>`. C'est ce qu'il faut
pour donner un intitulé commun à un groupe de cases à cocher ou de boutons
radio, à l'intérieur d'un `<fieldset>`.

```gjs live preview nebulix
import { PixLabel, PixRadioButton } from '@1024pix/nebulix-ember';

<template>
  <fieldset>
    <PixLabel @useAsLegend={{true}}>Statut de l'établissement</PixLabel>

    <PixRadioButton name="statut" @value="public">
      <:label>Public</:label>
    </PixRadioButton>
    <PixRadioButton name="statut" @value="prive">
      <:label>Privé</:label>
    </PixRadioButton>
  </fieldset>
</template>
```

## Masquer le libellé sans le supprimer

`@screenReaderOnly` retire le libellé de l'affichage mais le laisse annoncé par
les lecteurs d'écran.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-label'
  @name='PixLabelSignature'
/>
```
