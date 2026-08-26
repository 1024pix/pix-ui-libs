---
title: PixMultiSelect
---

# PixMultiSelect

`PixMultiSelect` propose plusieurs choix cumulables dans une liste déroulante.
Le champ affiche ensuite la liste des options retenues.

En dessous de cinq options, une série de `PixCheckbox` évite d'ouvrir un menu
pour rien.

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

Deux blocs sont attendus : `:label` intitule le champ, et le bloc par défaut
reçoit chaque option pour en rendre le texte. `@onChange` est appelée avec la
**liste complète** des valeurs sélectionnées, jamais avec la seule option qui
vient de changer.

## Rendre la liste cherchable

`@isSearchable` ajoute un champ de recherche en tête de liste. La recherche
interne ignore la casse et les accents.

```gjs live nebulix
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

## Personnaliser le texte du champ

Par défaut, le champ affiche les libellés des options retenues, séparés par des
virgules. Le bloc `:placeholder` remplace ce texte — utilisez-le quand la liste
des options choisies devient trop longue à lire, par exemple pour n'afficher
qu'un compteur.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-multi-select'
  @name='PixMultiSelectSignature'
/>
```
