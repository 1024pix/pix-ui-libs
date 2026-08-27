---
title: PixBlock
---

# PixBlock

`PixBlock` est le conteneur de base de Nebulix : un fond blanc, des coins
arrondis, une ombre légère et des marges intérieures cohérentes. Il sert à
poser un contenu sur une surface distincte de la page.

C'est une brique volontairement neutre : `PixCard`, `PixTable` et
`PixIndicatorCard` sont construits dessus. Utilisez-la directement lorsque
aucun de ces composants ne convient.

## Utilisation

```gjs live preview nebulix
import { PixBlock } from '@1024pix/nebulix-ember';

<template>
  <PixBlock>
    <h2>Informations de l'établissement</h2>
    <p>Collège Jean Moulin, Nantes.</p>
  </PixBlock>
</template>
```

Le bloc n'impose aucune structure : titres, textes et actions sont à votre
charge.

## Variantes

`@variant` accorde le bloc aux couleurs de l'application dans laquelle il
s'affiche.

```gjs live nebulix
import { PixBlock } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-blocks">
    <PixBlock @variant="primary">primary</PixBlock>
    <PixBlock @variant="orga">orga</PixBlock>
    <PixBlock @variant="certif">certif</PixBlock>
    <PixBlock @variant="admin">admin</PixBlock>
    <PixBlock @variant="modulix">modulix</PixBlock>
  </div>

  <style>
    .demo-blocks {
      display: flex;
      flex-wrap: wrap;
      gap: 1.5rem;
      align-items: flex-start;
    }
  </style>
</template>
```

## Densité

`@condensed` réduit les marges intérieures. Employez-le quand le bloc est
répété dans une liste, où la hauteur cumulée compte davantage que le confort de
lecture d'un bloc isolé.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/layout/pix-block'
  @name='PixBlockSignature'
/>
```
