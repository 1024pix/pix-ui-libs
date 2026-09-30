---
title: PixTag
---

# PixTag

`PixTag` permet de mettre en avant une information ou bien de la catégoriser.

> Il est possible de surcharger le style d'un `<PixTag>` via l'attribut `class`
> ainsi que de passer n'importe quel attribut sur le tag sous-jacente (div)

## Utilisation

```gjs live preview nebulix
import { PixTag } from '@1024pix/nebulix-ember';

<template>
  <PixTag @color="green-light">Terminée</PixTag>
</template>
```

## Couleurs

Il est possible de personnaliser la couleur des tag `@color`

```gjs live nebulix
import { PixTag } from '@1024pix/nebulix-ember';

const colors = [
  'white',
  'dark',
  'grey',
  'grey-light',
  'neutral',
  'yellow',
  'yellow-light',
  'blue',
  'blue-light',
  'green',
  'green-light',
  'success',
  'success-light',
  'purple',
  'purple-light',
  'orange',
  'orange-light',
  'error',
  'error-light',
  'orga',
];
<template>
  <div class="demo-tags">
    {{#each colors as |color|}}
      <figure><PixTag @color={{color}}> tag {{color}} </PixTag><figcaption
          class="pix-body-xs"
        >{{color}}</figcaption></figure>
    {{/each}}
  </div>
  <style>
    .demo-tags {
      display: flex;
      flex-wrap: wrap;
      gap: 1.5rem;
      align-items: flex-start;
    }
    figcaption {
      text-align: center;
    }
  </style>
</template>
```

## Icon

Il est possible de d'ajouter des icons `@iconBefore` `@iconAfter` et le type de l'icon `@plainIcon`

```gjs live nebulix
import { PixTag } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-tags">
    <PixTag @color="success-light" @iconBefore="checkCircle" @plainIcon={{true}}>checkCircle plain</PixTag>
    <PixTag @color="success-light" @iconAfter="checkCircle" @iconPosition="after">checkCircle basic
    </PixTag>
  </div>
  <style>
    .demo-tags {
      display: flex;
      flex-wrap: wrap;
      gap: 1.5rem;
      align-items: flex-start;
    }
  </style>
</template>
```

## Texte

Il est possible de passer le texte en majuscule avec `@textTransform`

```gjs live nebulix
import { PixTag } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-tags">
    <PixTag @color="success-light" @textTransform="uppercase">success uppercase</PixTag>
  </div>
  <style>
    .demo-tags {
      display: flex;
      flex-wrap: wrap;
      gap: 1.5rem;
      align-items: flex-start;
    }
  </style>
</template>
```

Il est possible de passer le texte en petit avec `@size`

```gjs live nebulix
import { PixTag } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-tags">
    <PixTag @color="error-light" @size="small" @iconBefore="close">Oups i did i again</PixTag>
  </div>
  <style>
    .demo-tags {
      display: flex;
      flex-wrap: wrap;
      gap: 1.5rem;
      align-items: flex-start;
    }
  </style>
</template>
```

## Arrondi

Il est possible de changer l'arrondi du PixTag avec `@type`

```gjs live nebulix
import { PixTag } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-tags">
    <PixTag @color="success-light" @type="squircle">squircle tag</PixTag>
  </div>
  <style>
    .demo-tags {
      display: flex;
      flex-wrap: wrap;
      gap: 1.5rem;
      align-items: flex-start;
    }
  </style>
</template>
```

## Étiquette supprimable

Passer `@onRemove` affiche un bouton de suppression à droite du texte. Il faut
obligatoirement alors aussi fournir `@texts.removeButtonLabel`, le libellé
accessible du bouton lu par les lecteurs d'écran.

```gjs live nebulix
import { PixTag } from '@1024pix/nebulix-ember';

const retirer = () => {
  // votre action
};

const texts = {
  removeButtonLabel: 'Supprimer',
};

<template>
  <PixTag @color="tertiary" @onRemove={{retirer}} @texts={{texts}}>
    Collège Jean Moulin
  </PixTag>
</template>
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/data-display/pix-tag'
  @name='PixTagSignature'
/>
```
