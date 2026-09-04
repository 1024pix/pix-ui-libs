---
title: PixCheckbox
---

# PixCheckbox

`PixCheckbox` permet de cocher une ou plusieurs options dans une liste (ex: accepter des conditions, activer
une option, sélectionner plusieurs choix...). Un cursor `pointer` est défini sur la checkbox et son label par défaut.

## Utilisation

Le libellé passe par le bloc _yield_ `:label`.

```gjs live preview nebulix
import { PixCheckbox } from '@1024pix/nebulix-ember';

<template>
  <PixCheckbox @id="cgu">
    <:label>J'accepte les conditions générales d'utilisation</:label>
  </PixCheckbox>
</template>
```

## Regrouper plusieurs cases

Regroupez des cases liées dans un `<fieldset>` intitulé par un `PixLabel` en
mode légende. Le groupe est ainsi annoncé une fois, avant les choix. Un espace vertical pour séparer deux cases qui se suivent est prévu.

```gjs live preview nebulix
import { PixCheckbox, PixLabel } from '@1024pix/nebulix-ember';

<template>
  <fieldset>
    <PixLabel @useAsLegend={{true}} class="legend-with-margin">Notifications que vous souhaitez
      recevoir</PixLabel>

    <PixCheckbox @id="notif-resultats">
      <:label>Résultats de mes campagnes</:label>
    </PixCheckbox>
    <PixCheckbox @id="notif-actualites">
      <:label>Actualités du service</:label>
    </PixCheckbox>
  </fieldset>

  <style>
    .legend-with-margin {
      margin-bottom: 1rem;
    }
  </style>
</template>
```

## Case désactivée

- L'attribut `@isDisabled` permet de désactiver la checkbox en conservant la possibilité de naviguer avec le clavier ou le lecteur d'écran. Il est préféré à l'attribut natif `disabled` qui empêche ces usages.

- Un cursor `not-allowed` est défini sur la checkbox et son label lorsqu'elle est dans un état disabled.

```gjs live nebulix
import { PixCheckbox } from '@1024pix/nebulix-ember';

<template>
  <PixCheckbox @id="disabled" @isDisabled={{true}}>
    <:label>Option désactivée</:label>
  </PixCheckbox>
</template>
```

## Case partiellement cochée

`@isIndeterminate` affiche un état intermédiaire, ni coché ni décoché (par exemple pour représenter une case « tout sélectionner » dont une partie
seulement des sous-cases est cochée).

```gjs live nebulix
import { PixCheckbox } from '@1024pix/nebulix-ember';

<template>
  <PixCheckbox @id="tout" @isIndeterminate={{true}}>
    <:label>Sélectionner tous les élèves</:label>
  </PixCheckbox>
</template>
```

# Focus sur Variant Modulix

Si le paramètre `@variant` est précisé avec la valeur `modulix`, la checkbox et son label sont visuellement regroupés dans un ensemble intégralement cliquable.

```gjs live preview nebulix
import { PixCheckbox } from '@1024pix/nebulix-ember';

<template>
  <PixCheckbox @id="modulix" @variant="modulix">
    <:label>Case avec variant modulix</:label>
  </PixCheckbox>
</template>
```

## Case désactivée

L'attribut `@isDisabled` est compatible avec le variant `modulix`, quand on veut afficher un feedback neutre.

```gjs live nebulix
import { PixCheckbox } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-stack">
    <PixCheckbox @id="not-checked-modulix" @isDisabled={{true}} @variant="modulix">
      <:label>Case désactivée non cochée</:label>
    </PixCheckbox>

    <PixCheckbox @id="checked-modulix" @isDisabled={{true}} checked={{true}} @variant="modulix">
      <:label>Case désactivée cochée</:label>
    </PixCheckbox>

    <PixCheckbox
      @id="indeterminate-modulix"
      @isDisabled={{true}}
      @isIndeterminate={{true}}
      @variant="modulix"
      checked={{true}}
    >
      <:label>Case désactivée partiellement cochée</:label>
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

## États de correction Modulix

Dans Modulix, après soumission de la réponse, la PixCheckbox est désactivée et peut s'afficher avec ces états :

- `success`

- `error`

```gjs live preview nebulix
import { PixCheckbox } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-stack">
    <PixCheckbox
      @id="rep-ok-modulix"
      @variant="modulix"
      @isDisabled={{true}}
      @state="success"
      checked={{true}}
    >
      <:label>Réponse succès</:label>
    </PixCheckbox>

    <PixCheckbox
      @id="rep-ko-modulix"
      @variant="modulix"
      @isDisabled={{true}}
      @state="error"
      checked={{true}}
    >
      <:label>Réponse erreur</:label>
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

## État déclaratif

L'état `@state="declarative"` est utilisé pour les réponses d'un module qui ne sont pas évaluées (par exemple, des questions déclaratives). La checkbox reste active par défaut.

```gjs live preview nebulix
import { PixCheckbox } from '@1024pix/nebulix-ember';

<template>
  <PixCheckbox @id="modulix" @variant="modulix" @state="declarative">
    <:label>Case avec variant modulix</:label>
  </PixCheckbox>
</template>
```

Combiné à `@isDisabled`, il permet d'afficher l'état après soumission :

- `@state=declarative-selected`: la proposition était sélectionnée

```gjs live preview nebulix
import { PixCheckbox } from '@1024pix/nebulix-ember';

<template>
  <PixCheckbox @id="modulix" @variant="modulix" @isDisabled="true" @state="declarative-selected">
    <:label>Case avec variant modulix</:label>
  </PixCheckbox>
</template>
```

# API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-checkbox'
  @name='PixCheckboxSignature'
/>
```
