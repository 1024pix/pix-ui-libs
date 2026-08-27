---
title: PixFilterableAndSearchableSelect
---

# PixFilterableAndSearchableSelect

`PixFilterableAndSearchableSelect` propose un choix unique dans une liste
d'options si longue qu'il faut d'abord la réduire. Il associe deux champs : un
filtre par catégories à gauche, la liste des options restantes à droite.

Réservez-le aux listes que la recherche seule ne suffit pas à rendre praticable.
Pour tout le reste, `PixSelect` avec `@isSearchable` fait le travail avec un
champ de moins.

## Utilisation

```gjs live preview nebulix
import { PixFilterableAndSearchableSelect } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

const options = [
  { category: 'Second degré', value: 'college', label: 'Collège' },
  { category: 'Second degré', value: 'lycee-gt', label: 'Lycée général et technologique' },
  { category: 'Second degré', value: 'lycee-pro', label: 'Lycée professionnel' },
  { category: 'Supérieur', value: 'universite', label: 'Université' },
  { category: 'Supérieur', value: 'cpge', label: 'CPGE' },
  { category: 'Supérieur', value: 'bts', label: 'BTS' },
];

export default class FilterableSelectDemo extends Component {
  @tracked value = null;

  onChange = (value) => {
    this.value = value;
  };

  <template>
    <PixFilterableAndSearchableSelect
      @options={{options}}
      @value={{this.value}}
      @onChange={{this.onChange}}
      @placeholder="Choisissez un type d'établissement"
      @categoriesPlaceholder="Catégories"
      @isSearchable={{true}}
    >
      <:label>Type d'établissement</:label>
      <:categoriesLabel>Filtrer par catégorie</:categoriesLabel>
    </PixFilterableAndSearchableSelect>
  </template>
}
```

Chaque option doit porter une `category` : c'est elle qui alimente la liste des
filtres. Tant qu'aucune catégorie n'est cochée, toutes les options restent
proposées.

Les deux blocs sont attendus. `:label` intitule l'ensemble, `:categoriesLabel`
intitule le filtre. Ils sont masqués visuellement mais annoncés aux lecteurs
d'écran : ne les laissez pas vides.

`@categoriesPlaceholder` est suivi automatiquement du nombre de catégories
cochées.

## Erreur

`@errorMessage` affiche un message sous les deux champs et leur applique le
style d'erreur.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-filterable-and-searchable-select'
  @name='PixFilterableAndSearchableSelectSignature'
/>
```
