---
title: PixCheckbox
---

# PixCheckbox

`PixCheckbox` recueille un choix indépendant : accepter des conditions, activer
une option, cocher plusieurs réponses dans une liste.

Quand les choix s'excluent l'un l'autre, c'est `PixRadioButton` qu'il faut
utiliser.

## Utilisation

```gjs live preview nebulix
import { PixCheckbox } from '@1024pix/nebulix-ember';

<template>
  <PixCheckbox @id="cgu">
    <:label>J'accepte les conditions générales d'utilisation</:label>
  </PixCheckbox>
</template>
```

Le libellé passe par le bloc `:label`. Formulez-le à la première personne et de
façon affirmative : une case cochée doit vouloir dire « oui ».

## Plusieurs cases

Regroupez des cases liées dans un `<fieldset>` intitulé par un `PixLabel` en
mode légende. Le groupe est ainsi annoncé une fois, avant les choix.

```gjs live nebulix
import { PixCheckbox, PixLabel } from '@1024pix/nebulix-ember';

<template>
  <fieldset>
    <PixLabel @useAsLegend={{true}}>Notifications que vous souhaitez recevoir</PixLabel>

    <PixCheckbox @id="notif-resultats">
      <:label>Résultats de mes campagnes</:label>
    </PixCheckbox>
    <PixCheckbox @id="notif-actualites">
      <:label>Actualités du service</:label>
    </PixCheckbox>
  </fieldset>
</template>
```

## Case partiellement cochée

`@isIndeterminate` affiche un état intermédiaire, ni coché ni décoché. Il ne
sert qu'à une chose : représenter une case « tout sélectionner » dont une partie
seulement des sous-cases est cochée.

```gjs live nebulix
import { PixCheckbox } from '@1024pix/nebulix-ember';

<template>
  <PixCheckbox @id="tout" @isIndeterminate={{true}}>
    <:label>Sélectionner tous les élèves</:label>
  </PixCheckbox>
</template>
```

## États de correction

`@state` affiche le résultat d'une correction, une fois la réponse validée. Le
composant annonce également cet état aux lecteurs d'écran, dans la langue
choisie par `@locale`.

```gjs live nebulix
import { PixCheckbox } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-stack">
    <PixCheckbox @id="rep-ok" @state="success" checked={{true}}>
      <:label>Réponse attendue</:label>
    </PixCheckbox>

    <PixCheckbox @id="rep-ko" @state="error" checked={{true}}>
      <:label>Réponse inattendue</:label>
    </PixCheckbox>
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

Les états `neutral`, `declarative` et `declarative-selected` ne s'appliquent
qu'avec `@variant="modulix"`.

## Case désactivée

`@isDisabled` empêche de modifier la case sans la retirer du flux de lecture :
elle reste annoncée par les lecteurs d'écran. Accompagnez-la toujours d'une
explication visible de la raison du blocage.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-checkbox'
  @name='PixCheckboxSignature'
/>
```
