---
title: PixRadioButton
---

# PixRadioButton

`PixRadioButton` propose un choix unique parmi plusieurs options mutuellement
exclusives. Quand les choix peuvent se cumuler, utilisez `PixCheckbox` ; quand
ils sont nombreux, `PixSelect` économise de la place.

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

Proposez toujours au moins deux options. N'en présélectionnez une que si elle
constitue un choix raisonnable par défaut pour la majorité des utilisateurs.

## Bouton désactivé

`@isDisabled` empêche de sélectionner l'option sans la masquer aux lecteurs
d'écran. Il est préféré à l'attribut natif `disabled` qui empêche ces usages.

## Textes affichés (@texts)

`@texts` fournit tous les textes du composant qui ne sont pas déjà passés par
le bloc `:label` : l'infobulle de l'astérisque obligatoire (`requiredLabel`),
le complément d'information sous le libellé (`subLabel`), et les messages
annoncés aux lecteurs d'écran pour chaque état de correction (`stateSuccess`,
`stateError`). Nebulix ne traduit rien lui-même : c'est à l'application
consommatrice de fournir ces textes, déjà traduits.

```gjs live preview nebulix
import { PixLabel, PixRadioButton } from '@1024pix/nebulix-ember';

const texts = {
  requiredLabel: 'Ce champ est obligatoire',
  subLabel: 'Un seul choix possible',
};

<template>
  <fieldset>
    <PixLabel @useAsLegend={{true}}>Statut de l'établissement</PixLabel>

    <PixRadioButton name="statut-texts" @value="public" @texts={{texts}}>
      <:label>Public</:label>
    </PixRadioButton>
  </fieldset>
</template>
```

## Focus sur Variant Modulix

Quand `@variant="modulix"`, le PixRdioButton est affiché avc un encadré autour du label.

- Le RadioButton et son label sont visuellement regroupés dans un ensemble intégralement cliquable.
- Le bouton radio (petit cercle à gauche du label), est ici volontairement masqué pour les besoins design des modules.

```gjs live preview nebulix
import { PixLabel, PixRadioButton } from '@1024pix/nebulix-ember';

<template>
  <PixRadioButton @variant="modulix" name="statut" @value="une réponse">
    <:label>Une réponse</:label>
  </PixRadioButton>
</template>
```

## État désactivé variant Modulix

Si `@isDisabled=true`, PixRadioButton apparaît désactivé, toujours sans cercle de "radio" affiché.

```gjs live preview nebulix
import { PixLabel, PixRadioButton } from '@1024pix/nebulix-ember';

<template>
  <PixRadioButton @variant="modulix" name="statut" @value="une réponse" @isDisabled="true">
    <:label>Une réponse désactivée</:label>
  </PixRadioButton>
</template>
```

## État désactivé variant Modulix

Si `@isDisabled=true`, PixRadioButton apparaît désactivé, toujours sans cercle de "radio" affiché.

```gjs live preview nebulix
import { PixLabel, PixRadioButton } from '@1024pix/nebulix-ember';

<template>
  <PixRadioButton @variant="modulix" name="statut" @value="une réponse" @isDisabled="true">
    <:label>Une réponse désactivée</:label>
  </PixRadioButton>
</template>
```

## États de correction Modulix

Si `@isDisabled=true`, on peut utiliser `@state` pour donner une information à l'utilisateur :

- `@state="success` si réponse correcte
- `@state="error` si réponse fausse

On n'affiche pas de SVG de succès ou d'erreur. (contrairement à la PixCheckbox variant modulix)

```gjs live nebulix
import { PixRadioButton } from '@1024pix/nebulix-ember';

const texts = {
  stateSuccess: 'Sélection correcte',
  stateError: 'Sélection incorrecte',
};

<template>
  <div class="demo-stack-modulix">
    <PixRadioButton
      @variant="modulix"
      name="correction-ok"
      @value="ok"
      @isDisabled="true"
      @state="success"
      @texts={{texts}}
    >
      <:label>Une réponse correcte</:label>
    </PixRadioButton>

    <PixRadioButton
      @variant="modulix"
      name="correction-ko"
      @value="ko"
      @isDisabled="true"
      @state="error"
      @texts={{texts}}
    >
      <:label>Une mauvaise réponse</:label>
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

# API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-radio-button'
  @name='PixRadioButtonSignature'
/>
```
