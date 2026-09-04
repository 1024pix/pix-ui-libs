---
title: PixMultiSelect
---

# PixMultiSelect

`PixMultiSelect` propose plusieurs choix cumulables dans une liste déroulante.
Le champ affiche ensuite la liste des options retenues (leur label), séparées par une virgule.

## Utilisation

```gjs live preview nebulix
import { PixMultiSelect } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

const options = [
  { value: 'cm1', label: 'CM1' },
  { value: 'cm2', label: 'CM2' },
  { value: '6e', label: '6e' },
  { value: '5e', label: '5e' },
];

export default class MultiSelectDemo extends Component {
  @tracked values = [];

  onChange = (values) => {
    this.values = values;
  };

  <template>
    <PixMultiSelect
      @options={{options}}
      @values={{this.values}}
      @onChange={{this.onChange}}
      @placeholder="Choisissez un ou plusieurs niveaux"
    >
      <:label>Niveaux concernés</:label>
      <:default as |option|>{{option.label}}</:default>
    </PixMultiSelect>
  </template>
}
```

Deux blocs obligatoires sont attendus : `:label` intitule le champ, et le bloc par défaut
reçoit chaque option pour en rendre le texte.
`@onChange` est appelée avec la **liste complète** des valeurs sélectionnées, jamais avec la seule option qui vient de changer.

## Bloc `:placeholder`

Le bloc `:placeholder` permet de surcharger le comportement par défaut du placeholder, à savoir le texte qui s'affiche lorsqu'aucune option n'est cochée vient de `@placeholder`, puis il est remplacé par la liste des options cochées. Avec `:placeholder` c'est ce qu'il y a dedans qui s'affiche tout le temps.

```gjs live preview nebulix
import { PixMultiSelect } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

const options = [
  { value: 'cm1', label: 'CM1' },
  { value: 'cm2', label: 'CM2' },
  { value: '6e', label: '6e' },
  { value: '5e', label: '5e' },
];

export default class MultiSelectDemo extends Component {
  @tracked values = [];

  onChange = (values) => {
    this.values = values;
  };

  <template>
    <PixMultiSelect
      @options={{options}}
      @values={{this.values}}
      @onChange={{this.onChange}}
      @placeholder="Choisissez un ou plusieurs niveaux"
    >
      <:label>Niveaux concernés</:label>
      <:default as |option|>{{option.label}}</:default>
      <:placeholder>Ce placeholder s'affichera tout le temps</:placeholder>
    </PixMultiSelect>
  </template>
}
```

## Utilisation avec autre chose que du texte

Il est possible d'utiliser un composant enfant comme option. Par exemples le `PixStars`.

```gjs live preview nebulix
import { PixMultiSelect, PixStars } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { fn } from '@ember/helper';

const options = [
  { label: '0', value: '0', total: 3 },
  { label: '1', value: '1', total: 3 },
  { label: '2', value: '2', total: 3 },
  { label: '3', value: '3', total: 3 },
];

export default class MultiSelectDemo extends Component {
  @tracked values = [];

  onChange = (values) => {
    this.values = values;
  };

  getAlternativeDescription = (option) => {
    return `Étoiles ${option.value} sur ${option.total}`;
  };

  <template>
    <PixMultiSelect
      @options={{options}}
      @values={{this.values}}
      @onChange={{this.onChange}}
      @placeholder="Choisissez un ou plusieurs niveaux"
    >
      <:label>Niveaux concernés</:label>
      <:default as |option|>
        <PixStars
          @alt={{fn this.getAlternativeDescription option}}
          @count={{option.value}}
          @total={{option.total}}
        />
      </:default>
    </PixMultiSelect>
  </template>
}
```

## Rendre la liste cherchable

`@isSearchable` ajoute un champ de recherche en tête de liste. La recherche
interne ignore la casse et les accents.

On peut utiliser `@emptyMessage` pour indiquer le message à afficher lorsqu'aucune option ne correspond.

Lorsque `@isSearchable` est à `true` il est obligatoire de renseigner `@searchPlaceholder`.

```gjs live preview nebulix
import { PixMultiSelect } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

const options = [
  { value: 'creteil', label: 'Créteil' },
  { value: 'grenoble', label: 'Grenoble' },
  { value: 'lille', label: 'Lille' },
  { value: 'nantes', label: 'Nantes' },
  { value: 'orleans-tours', label: 'Orléans-Tours' },
];

export default class SearchableMultiSelectDemo extends Component {
  @tracked values = [];

  onChange = (values) => {
    this.values = values;
  };

  <template>
    <PixMultiSelect
      @options={{options}}
      @values={{this.values}}
      @onChange={{this.onChange}}
      @placeholder="Choisissez une ou plusieurs académies"
      @isSearchable={{true}}
      @searchPlaceholder="Rechercher"
      @emptyMessage="Aucune académie ne correspond"
    >
      <:label>Académies</:label>
      <:default as |option|>{{option.label}}</:default>
    </PixMultiSelect>
  </template>
}
```

`@onSearch` prend la main sur le filtrage interne, pour interroger un serveur et
fournir vous-même les options correspondantes.

## Classname

L'attribut `@className` permet de surcharger la classe du bouton d'ouverture.

```gjs live nebulix
import { PixMultiSelect } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

const options = [
  { value: 'red', label: 'Rouge' },
  { value: 'green', label: 'Vert' },
  { value: 'blue', label: 'Bleu' },
  { value: 'yellow', label: 'Jaune' },
  { value: 'purple', label: 'Violet' },
];

export default class ClassnameMultiSelectDemo extends Component {
  @tracked values = [];

  onChange = (values) => {
    this.values = values;
  };

  <template>
    <PixMultiSelect
      @options={{options}}
      @values={{this.values}}
      @onChange={{this.onChange}}
      @placeholder="Choisissez une ou plusieurs couleurs"
      @className="my-custom-class"
    >
      <:label>Couleurs</:label>
      <:default as |option|>{{option.label}}</:default>
    </PixMultiSelect>

    <style>
      .my-custom-class {
        border: 3px red solid !important;
      }
    </style>
  </template>
}
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-multi-select'
  @name='PixMultiSelectSignature'
/>
```
