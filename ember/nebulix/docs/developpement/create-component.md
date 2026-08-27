---
title: Créer un composant
---

# Créer un composant

Les composants vivent dans `ember/nebulix/src/components`, rangés par rubrique :
`actions`, `forms`, `navigation`, `overlay`… Le dossier dans lequel vous posez le
composant détermine la rubrique sous laquelle il apparaîtra dans cette
documentation.

## Les étapes

1. Créer `src/components/<rubrique>/pix-mon-composant.gjs`, et son `.scss` s'il a des styles.
2. Écrire le composant : le JSDoc qui le type, puis la classe et son `<template>`.
3. Déclarer son `.scss` dans `src/components/index.scss`.
4. Exporter le composant dans `src/index.js`.
5. Écrire son test, dans `ember/test-app/tests` — voir la page **Tester un composant**.
6. Écrire sa page de documentation, à côté du `.gjs` — voir la page **Documenter un composant**.
7. Ajouter un changeset avec `pnpm changeset`, sans quoi la modification ne sera pas publiée.

## Les fichiers

Un composant, c'est trois fichiers portant le même nom, dans le même dossier :

```
src/components/layout/pix-block.gjs   la logique et le template
src/components/layout/pix-block.scss  les styles
src/components/layout/pix-block.md    la documentation
```

Le `.scss` est facultatif : un composant qui n'apporte aucun style ne le crée
pas. Le `.gjs` et le `.md`, eux, sont toujours là.

## Écrire le composant

```gjs
// src/components/layout/pix-block.gjs
import Component from '@glimmer/component';
import { warn } from '@ember/debug';

/**
 * @typedef {object} PixMonComposantArgs
 * @property {'primary' | 'orga' | 'certif'} [variant] - Application à laquelle le bloc appartient, qui détermine ses couleurs. Par défaut : `primary`.
 * @property {boolean} [condensed] - Réduit les espacements intérieurs.
 */

/**
 * @typedef {object} PixMonComposantSignature
 * @property {HTMLDivElement} Element
 * @property {PixMonComposantArgs} Args
 * @property {{ default: [] }} Blocks
 */

export default class PixMonComposant extends Component {
  get variant() {
    const value = this.args.variant ?? 'primary';

    warn(
      `PixMonComposant: @variant "${value}" should be primary, orga, certif`,
      ['primary', 'orga', 'certif'].includes(value),
      { id: 'pix-ui.pix-mon-composant.variant.not-valid' },
    );

    return value;
  }

  get cssClass() {
    const cssClass = ['pix-mon-composant', `pix-mon-composant--variant-${this.variant}`];

    if (this.args.condensed) {
      cssClass.push('pix-mon-composant--condensed');
    }

    return cssClass.join(' ');
  }

  <template>
    <div class={{this.cssClass}} ...attributes>
      {{yield}}
    </div>
  </template>
}
```

Les deux `@typedef` **typent** le composant : `ember-tsc` les transforme en
fichiers de types dans `declarations/`, qui alimentent à la fois
l'auto-complétion dans les applications et le tableau d'API de sa page de
documentation. Comment les écrire en détail est expliqué dans
la page **Documenter un composant**.

Le reste tient en six conventions :

- Le **fichier** est en kebab-case préfixé `pix-`, la **classe** porte le même
  nom en PascalCase : `pix-mon-composant.gjs` → `PixMonComposant`.
- L'élément racine reçoit **`...attributes`**, pour que l'application puisse lui
  passer une classe ou un attribut. S'il accepte un contenu, il contient
  **`{{yield}}`**.
- Les **classes CSS suivent BEM** : `pix-mon-composant--variant-primary`,
  `pix-mon-composant--condensed`.
- Elles sont **assemblées dans un getter `cssClass`**, jamais dans le template.
- Les **valeurs par défaut vivent dans un getter** (`this.args.variant ?? 'primary'`).
  Les `args` ne sont jamais modifiés.
- Une valeur d'argument invalide déclenche un **`warn`** de `@ember/debug` : le
  développeur est averti, mais le rendu n'est pas cassé.

## Les styles

```scss
// src/components/layout/pix-block.scss
.pix-mon-composant {
  padding: var(--pix-spacing-3x);
  background-color: var(--pix-neutral-0);

  &--variant-orga {
    color: var(--pix-primary-500);
  }

  &--condensed {
    padding: 0;
  }
}
```

Toutes les valeurs viennent des **design tokens**, sous forme de variables
`var(--pix-…)` : couleurs, espacements, rayons, typographies. Aucune valeur en
dur.

Le fichier n'est pas importé depuis le `.gjs` : il faut l'ajouter à
`src/components/index.scss`, qui rassemble les styles de tous les composants, à
sa place dans l'ordre alphabétique.

```scss
@use './layout/pix-mon-composant';
```

## Exporter le composant

Un composant absent de `src/index.js` n'existe pas pour les applications, ni
pour ses propres tests. Ajoutez-y sa ligne, groupée par rubrique puis triée par
ordre alphabétique :

```js
export { default as PixMonComposant } from './components/layout/pix-mon-composant.gjs';
```
