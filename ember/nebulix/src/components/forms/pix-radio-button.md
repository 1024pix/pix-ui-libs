---
title: PixRadioButton
---

# PixRadioButton

`PixRadioButton` propose un choix unique parmi plusieurs options mutuellement
exclusives. Quand les choix peuvent se cumuler, utilisez `PixCheckbox` ; quand
ils sont nombreux, `PixSelect` économise la place.

## Utilisation

Les boutons d'un même groupe partagent le même attribut `name` : c'est lui qui
les rend exclusifs.

```gjs live preview nebulix
import { PixLabel, PixRadioButton } from '@1024pix/nebulix-ember';

<template>
  <fieldset>
    <PixLabel @useAsLegend={{true}}>Statut de l'établissement</PixLabel>

    <PixRadioButton name="statut" @value="public">
      <:label>Public</:label>
    </PixRadioButton>
    <PixRadioButton name="statut" @value="prive-sous-contrat">
      <:label>Privé sous contrat</:label>
    </PixRadioButton>
    <PixRadioButton name="statut" @value="prive-hors-contrat">
      <:label>Privé hors contrat</:label>
    </PixRadioButton>
  </fieldset>
</template>
```

Le `<fieldset>` et sa légende ne sont pas optionnels : sans eux, un utilisateur
de lecteur d'écran entend les options sans savoir à quelle question elles
répondent.

Proposez toujours au moins deux options, et n'en présélectionnez une que si elle
constitue un choix raisonnable par défaut pour la majorité des utilisateurs.

## États de correction

`@state` affiche le résultat d'une correction, une fois la réponse validée, et
l'annonce aux lecteurs d'écran.

```gjs live nebulix
import { PixRadioButton } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-stack">
    <PixRadioButton name="correction" @value="ok" @state="success" checked={{true}}>
      <:label>Bonne réponse</:label>
    </PixRadioButton>

    <PixRadioButton name="correction-ko" @value="ko" @state="error" checked={{true}}>
      <:label>Mauvaise réponse</:label>
    </PixRadioButton>
  </div>

  <style>
    .demo-stack {
      display: flex;
      flex-direction: column;
      gap: 0.75rem;
    }
  </style>
</template>
```

## Bouton désactivé

`@isDisabled` empêche de sélectionner l'option sans la masquer aux lecteurs
d'écran. Expliquez à côté pourquoi ce choix n'est pas disponible.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-radio-button'
  @name='PixRadioButtonSignature'
/>
```
