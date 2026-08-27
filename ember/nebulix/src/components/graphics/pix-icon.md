---
title: PixIcon
---

# PixIcon

`PixIcon` affiche une icône du jeu Pix. Toutes proviennent d'un même fichier :
vous n'avez qu'à en donner le nom.

La liste complète des noms disponibles est présentée dans la page
**Design tokens › Icons**.

## Utilisation

```gjs live preview nebulix
import { PixIcon } from '@1024pix/nebulix-ember';

<template>
  <PixIcon @name="check" @ariaHidden={{true}} />
  <PixIcon @name="bell" @ariaHidden={{true}} />
  <PixIcon @name="delete" @ariaHidden={{true}} />
</template>
```

## Décorative ou porteuse de sens

C'est la seule question à se poser, et elle décide de l'accessibilité de votre
écran.

Une icône est **décorative** quand un texte voisin dit déjà la même chose : la
loupe à côté du mot « Rechercher », l'enveloppe devant une adresse e-mail.
Posez alors `@ariaHidden={{true}}` pour que les lecteurs d'écran l'ignorent, au
lieu d'annoncer deux fois la même information.

Une icône est **porteuse de sens** quand elle est seule à dire quelque chose :
une croix qui signale une ligne en erreur, un cadenas qui indique un contenu
verrouillé. Donnez-lui alors un `@title` qui exprime cette information — pas le
nom du dessin.

```gjs live nebulix
import { PixIcon } from '@1024pix/nebulix-ember';

<template>
  <p>
    <PixIcon @name="lock" @title="Contenu verrouillé" />
    Parcours avancé
  </p>

  <p>
    <PixIcon @name="search" @ariaHidden={{true}} />
    Rechercher un élève
  </p>
</template>
```

Une icône sans `@ariaHidden` ni `@title` est annoncée sans intitulé : elle
ajoute du bruit sans rien apporter.

Pour une icône qui déclenche une action, ne posez pas de `@title` : c'est
`PixIconButton` qu'il vous faut, avec son `@ariaLabel`.

## Variante pleine

`@plainIcon` affiche la version pleine de l'icône, quand elle existe. Le trait
est le style par défaut ; le plein sert à marquer un état actif ou une mise en
avant. Gardez le même style au sein d'un même écran.

```gjs live nebulix
import { PixIcon } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-icons">
    <figure>
      <PixIcon @name="bell" @ariaHidden={{true}} />
      <figcaption>par défaut</figcaption>
    </figure>

    <figure>
      <PixIcon @name="bell" @plainIcon={{true}} @ariaHidden={{true}} />
      <figcaption>plainIcon</figcaption>
    </figure>
  </div>

  <style>
    .demo-icons {
      display: flex;
      flex-wrap: wrap;
      gap: 1.5rem;
      align-items: flex-start;
    }

    .demo-icons figure {
      display: flex;
      flex-direction: column;
      gap: 0.5rem;
      align-items: center;
      margin: 0;
    }

    .demo-icons figcaption {
      font-family: monospace;
      font-size: 0.8rem;
      color: var(--pix-neutral-500);
    }
  </style>
</template>
```

## Taille et couleur

L'icône hérite de la taille et de la couleur du texte qui l'entoure. Pour
l'ajuster, agissez sur son contexte ou passez une classe : le composant n'expose
aucun argument pour cela.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/graphics/pix-icon'
  @name='PixIconSignature'
/>
```
