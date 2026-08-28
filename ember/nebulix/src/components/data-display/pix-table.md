---
title: PixTable
---

# PixTable

`PixTable` affiche un tableau html.
Les données

## Utilisation

Les colonnes sont décrites une seule fois, dans le bloc `:columns`, avec des
`PixTableColumn`.

```gjs live preview nebulix
import { PixTable, PixTableColumn, PixTag, PixButtonLink } from '@1024pix/nebulix-ember';

import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

const participants = [
  {
    id: 1,
    lastName: 'Dupont',
    firstName: 'Marie',
    score: 512,
    tag: '6ieme',
    date: '13/05/2020',
    link: { label: 'Pix', href: 'https://pix.fr' },
  },
  {
    id: 2,
    lastName: 'Martin',
    firstName: 'Lucas',
    score: 438,
    tag: '5ieme',
    date: '03/05/2021',
    link: { label: 'Pix', href: 'https://pix.fr' },
  },
  {
    id: 3,
    lastName: 'Bernard',
    firstName: 'Sofia',
    score: 605,
    tag: '6ieme',
    date: '09/11/2023',
    link: { label: 'Pix', href: 'https://pix.fr' },
  },
];

export default class TableDemo extends Component {
  @tracked
  sortOrder = null;

  @tracked
  participants = participants.slice();

  @action
  trier() {
    if (this.sortOrder === 'desc') {
      this.sortOrder = 'asc';
    } else {
      this.sortOrder = 'desc';
    }

    this.participants = participants
      .slice()
      .sort((a, b) =>
        this.sortOrder === 'desc'
          ? a.lastName.localeCompare(b.lastName)
          : b.lastName.localeCompare(a.lastName),
      );
  }

  <template>
    <PixTable
      @data={{this.participants}}
      @caption="Participants à la campagne"
      @variant="orga"
      @displayCaption="true"
    >
      <:columns as |row context|>
        <PixTableColumn
          @isMainRow={{true}}
          @context={{context}}
          @onSort={{this.trier}}
          @sortOrder={{this.sortOrder}}
          ariaLabelDefaultSort="Trier par nom"
          ariaLabelSortAsc="Trier dans l'ordre croissant"
          ariaLabelSortDesc="Trier dans l'ordre décroissant"
        >
          <:header>
            Nom
          </:header>
          <:cell>
            {{row.lastName}}
          </:cell>
        </PixTableColumn>
        <PixTableColumn @context={{context}} class="table__column--wide">
          <:header>
            Prénom
          </:header>
          <:cell>
            <i>{{row.firstName}}</i>
          </:cell>
        </PixTableColumn>
        <PixTableColumn @context={{context}} @type="number">
          <:header>
            Score
          </:header>
          <:cell>
            {{row.score}}
          </:cell>
        </PixTableColumn>
        <PixTableColumn @context={{context}} @type="tag">
          <:header>
            Classe
          </:header>
          <:cell>
            <PixTag>{{row.tag}}</PixTag>
          </:cell>
        </PixTableColumn>
        <PixTableColumn @context={{context}} @type="tagDate">
          <:header>
            tag + date
          </:header>
          <:cell>
            <PixTag>{{row.tag}}</PixTag>
          </:cell>
          <:subCell>{{row.date}}</:subCell>
        </PixTableColumn>
        <PixTableColumn @context={{context}} @type="link">
          <:header>
            Lien
          </:header>
          <:cell>
            <PixButtonLink
              href={{row.link.url}}
              target="_blank"
              @variant="tertiary"
              @iconBefore="openNew"
            >{{row.link.label}}</PixButtonLink>
          </:cell>
        </PixTableColumn>
      </:columns>
    </PixTable>
    <style>
      .table__column--wide {
        width: 300px;
      }
    </style>
  </template>
}
```

`@caption` est **obligatoire** : c'est le résumé du tableau, lu avant son
contenu. Il n'est pas affiché, sauf si vous ajoutez `@displayCaption="true"`.
On peut préciser un variant pour adpater la couleur du container.

## Lignes cliquables

`@onRowClick` reçoit la ligne cliquée et rend les lignes interactives.
Chaque ligne et reçoit en paramètre l'objet complet de la ligne.
Les lignes prennent alors un curseur pointer et un fond au survol.
Le clic n'étant pas accessible au clavier. le `<tr>` n'est ni focusable
ni activable au clavier.

Pour une action principale, placer un vrai lien ou bouton dans une cellule
(voir le variant link de PixTableColumn).

## Densité et variantes

`@condensed` réduit la hauteur des cellules, pour les tables à forte densité
de données.

```gjs live nebulix
import { PixTable, PixTableColumn, PixTag } from '@1024pix/nebulix-ember';

const participants = [
  { id: 1, lastName: 'Dupont', firstName: 'Marie', score: 512, tag: '6ieme' },
  { id: 2, lastName: 'Martin', firstName: 'Lucas', score: 438, tag: '5ieme' },
  { id: 3, lastName: 'Bernard', firstName: 'Sofia', score: 605, tag: '6ieme' },
];

<template>
  <PixTable
    @data={{participants}}
    @caption="Participants à la campagne"
    @variant="orga"
    @displayCaption={{true}}
    @condensed={{true}}
  >
    <:columns as |row context|>
      <PixTableColumn @context={{context}}>
        <:header>
          Nom
        </:header>
        <:cell>
          {{row.lastName}}
        </:cell>
      </PixTableColumn>
      <PixTableColumn @context={{context}} class="table__column--wide">
        <:header>
          Prénom
        </:header>
        <:cell>
          <i>{{row.firstName}}</i>
        </:cell>
      </PixTableColumn>
      <PixTableColumn @context={{context}} @type="number">
        <:header>
          Score
        </:header>
        <:cell>
          {{row.score}}
        </:cell>
      </PixTableColumn>
      <PixTableColumn @context={{context}} @type="tag">
        <:header>
          Classe
        </:header>
        <:cell>
          <PixTag>{{row.tag}}</PixTag>
        </:cell>
      </PixTableColumn>
    </:columns>
  </PixTable>
  <style>
    .table__column--wide {
      width: 300px;
    }
  </style>
</template>
```

## PixTableColumn

Une colonne d'un PixTable, gère l'affichage de l'en-tête et des cellules d'une colonne.

`@onSort` rend la colonne triable et `@sortOrder` indique le sens appliqué
(valeurs possible : `asc`, `desc`, `null` ). Les trois libellés
`@ariaLabelDefaultSort`, `@ariaLabelSortAsc` et `@ariaLabelSortDesc` permettent de definir les labels des boutons de tri.
Ils sont obligatoires à partir du moment ou l'on fournit `@onSort`.

On peut définir le type d'une colonne avec `@type` (`text`, `number`, `tag`, `tagDate`, `link`)

`@isMainRow` Permet de définir la cellule qui portera la valeur principale
de la ligne entière

## API Docs

### PixTable

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/data-display/pix-table'
  @name='PixTableSignature'
/>
```

### PixTableColumn

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/data-display/pix-table-column'
  @name='PixTableColumnSignature'
/>
```
