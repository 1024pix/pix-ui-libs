---
title: PixTable
---

# PixTable

`PixTable` affiche une liste d'objets comparables : des participants, des
sessions, des établissements. Il rend un vrai `<table>`, ce qui permet aux
lecteurs d'écran d'annoncer chaque cellule avec l'en-tête de sa colonne.

Ne l'utilisez pas pour mettre en page : un tableau se justifie quand les données
se comparent d'une ligne à l'autre.

## Utilisation

Les colonnes sont décrites une seule fois, dans le bloc `:columns`, avec
`PixTableColumn`. Ce bloc est rendu une fois pour l'en-tête, puis une fois par
ligne : `PixTableColumn` s'appuie sur le paramètre `context` pour savoir lequel
des deux il doit produire.

```gjs live preview nebulix
import { PixTable, PixTableColumn } from '@1024pix/nebulix-ember';

const participants = [
  { id: 1, nom: 'Dupont', prenom: 'Marie', score: 512 },
  { id: 2, nom: 'Martin', prenom: 'Lucas', score: 438 },
  { id: 3, nom: 'Bernard', prenom: 'Sofia', score: 605 },
];

<template>
  <PixTable @data={{participants}} @caption="Participants à la campagne" @variant="orga">
    <:columns as |participant context|>
      <PixTableColumn @context={{context}} @isMainRow={{true}}>
        <:header>Nom</:header>
        <:cell>{{participant.nom}}</:cell>
      </PixTableColumn>

      <PixTableColumn @context={{context}}>
        <:header>Prénom</:header>
        <:cell>{{participant.prenom}}</:cell>
      </PixTableColumn>

      <PixTableColumn @context={{context}} @type="number">
        <:header>Score</:header>
        <:cell>{{participant.score}}</:cell>
      </PixTableColumn>
    </:columns>
  </PixTable>
</template>
```

`@caption` est **obligatoire** : c'est le résumé du tableau, lu avant son
contenu. Il n'est pas affiché, sauf si vous ajoutez `@displayCaption`.

`@isMainRow` désigne la colonne qui identifie la ligne — le nom, l'intitulé.
Sa cellule est rendue dans un `<th>`, ce qui permet aux lecteurs d'écran de
situer les autres cellules de la ligne. Une seule colonne par tableau.

`@type` adapte l'alignement au contenu : `number` cale les chiffres à droite,
et `checkbox`, `tag`, `tagDate` et `link` ajustent les espacements.

## Trier une colonne

`@onSort` rend la colonne triable et `@sortOrder` indique le sens appliqué. Les
trois libellés `@ariaLabelDefaultSort`, `@ariaLabelSortAsc` et
`@ariaLabelSortDesc` nomment le bouton selon l'état courant : ils sont
obligatoires, car le bouton n'a pas de texte visible. Écrivez-y l'action à
venir, pas l'état actuel — « Trier par score croissant ».

```gjs live nebulix
import { PixTable, PixTableColumn } from '@1024pix/nebulix-ember';

const sessions = [
  { id: 1, ville: 'Nantes', places: 24 },
  { id: 2, ville: 'Lille', places: 16 },
];

const trier = () => {
  // votre action
};

<template>
  <PixTable @data={{sessions}} @caption="Sessions de certification" @variant="certif">
    <:columns as |session context|>
      <PixTableColumn @context={{context}} @isMainRow={{true}}>
        <:header>Ville</:header>
        <:cell>{{session.ville}}</:cell>
      </PixTableColumn>

      <PixTableColumn
        @context={{context}}
        @type="number"
        @onSort={{trier}}
        @sortOrder="asc"
        @ariaLabelDefaultSort="Trier par nombre de places"
        @ariaLabelSortAsc="Trier par nombre de places croissant"
        @ariaLabelSortDesc="Trier par nombre de places décroissant"
      >
        <:header>Places</:header>
        <:cell>{{session.places}}</:cell>
      </PixTableColumn>
    </:columns>
  </PixTable>
</template>
```

## Lignes cliquables

`@onRowClick` reçoit la ligne cliquée et rend les lignes interactives. Le clic
n'étant pas accessible au clavier, placez dans la ligne un lien vers la même
destination — la colonne principale s'y prête.

## Densité et variantes

`@condensed` réduit la hauteur des lignes, pour un tableau long consulté d'un
seul coup d'œil. `@variant` accorde l'en-tête aux couleurs de l'application.

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
