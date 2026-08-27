---
title: PixSelect
---

# PixSelect

`PixSelect` propose un choix unique dans une liste déroulante. Il remplace le
`<select>` natif pour offrir la recherche, les catégories et les icônes.

En dessous de cinq options, `PixRadioButton` laisse tout voir d'un coup d'œil et
demande un clic de moins.

## Utilisation

```gjs live preview nebulix
import { PixSelect } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

const options = [
  { value: 'college', label: 'Collège' },
  { value: 'lycee-gt', label: 'Lycée général et technologique' },
  { value: 'lycee-pro', label: 'Lycée professionnel' },
];

export default class SelectDemo extends Component {
  @tracked value = null;

  onChange = (value) => {
    this.value = value;
  };

  <template>
    <PixSelect
      @options={{options}}
      @value={{this.value}}
      @onChange={{this.onChange}}
      @placeholder="Choisissez un type d'établissement"
    >
      <:label>Type d'établissement</:label>
    </PixSelect>
  </template>
}
```

`@options` et `@onChange` sont obligatoires. Chaque option est un objet
`{ value, label }` : `label` est ce que voit l'utilisateur, `value` ce que reçoit
`@onChange`.

`@placeholder` sert deux rôles : il s'affiche tant qu'aucune option n'est
choisie, et il intitule l'option qui permet de revenir à cet état. Écrivez-y une
invitation à choisir, pas une option parmi les autres.

## Rendre la liste cherchable

`@isSearchable` ajoute un champ de recherche en tête de liste. Au-delà d'une
dizaine d'options, il devient nécessaire.

```gjs live nebulix
import { PixSelect } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

const options = [
  { value: '01', label: 'Ain' },
  { value: '02', label: 'Aisne' },
  { value: '03', label: 'Allier' },
  { value: '04', label: 'Alpes-de-Haute-Provence' },
  { value: '05', label: 'Hautes-Alpes' },
  { value: '06', label: 'Alpes-Maritimes' },
];

export default class SearchableSelectDemo extends Component {
  @tracked value = null;

  onChange = (value) => {
    this.value = value;
  };

  <template>
    <PixSelect
      @options={{options}}
      @value={{this.value}}
      @onChange={{this.onChange}}
      @placeholder="Choisissez un département"
      @isSearchable={{true}}
      @searchPlaceholder="Rechercher"
      @emptySearchMessage="Aucun département ne correspond"
    >
      <:label>Département</:label>
    </PixSelect>
  </template>
}
```

Par défaut, la recherche filtre les options fournies. `@onSearch` prend la main
sur ce filtrage : utilisez-le pour interroger un serveur et fournir vous-même
les options correspondantes.

`@emptySearchMessage` est le seul retour dont dispose l'utilisateur quand rien ne
correspond. Ne le laissez pas vide.

## Regrouper les options

Une `category` sur une option la range sous un intertitre. Regroupez dès que les
options relèvent de familles distinctes.

```gjs live nebulix
import { PixSelect } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

const options = [
  { category: 'Second degré', value: 'college', label: 'Collège' },
  { category: 'Second degré', value: 'lycee', label: 'Lycée' },
  { category: 'Supérieur', value: 'universite', label: 'Université' },
  { category: 'Supérieur', value: 'cpge', label: 'CPGE' },
];

export default class GroupedSelectDemo extends Component {
  @tracked value = null;

  onChange = (value) => {
    this.value = value;
  };

  <template>
    <PixSelect
      @options={{options}}
      @value={{this.value}}
      @onChange={{this.onChange}}
      @placeholder="Choisissez un type d'établissement"
    >
      <:label>Type d'établissement</:label>
    </PixSelect>
  </template>
}
```

## Erreur

`@errorMessage` affiche un message sous le champ et lui applique le style
d'erreur.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-select'
  @name='PixSelectSignature'
/>
```
