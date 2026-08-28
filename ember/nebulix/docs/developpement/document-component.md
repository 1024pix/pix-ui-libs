---
title: Documenter un composant
---

# Documenter un composant

La documentation d'un composant est un fichier `.md` posé à côté de son `.gjs`.

## Lancer la doc

Depuis la racine du dépôt :

```bash
pnpm doc
```

La documentation est générée avec [Kolay](https://kolay.nullvoxpopuli.com/) dans l'app `ember/docs-app` et servie sur [http://localhost:4200](http://localhost:4200).

## Créer la page

Le fichier de documentation porte le nom du composant et vit dans **le même dossier** que lui :

```sh
src/components/graphics/pix-icon.gjs    # le code du composant
src/components/graphics/pix-icon.scss   # les styles
src/components/graphics/pix-icon.md     # la documentation
```

L'ordre des **categories** est fixé dans `src/components/meta.jsonc`, cette liste doit être **exhaustive**:

```jsonc
{
  "order": ["actions", "content", "data-display", "..."],
}
```

## Le squelette d'une page

Une page de composant suit toujours cet ordre :

````md
---
title: PixMonComposant
new: true
---

# PixMonComposant

Ce que fait le composant et quand s'en servir.
Deux ou trois phrases, pas une liste d'arguments.

## Utilisation

Le cas nominal, celui qu'on copie-colle pour démarrer.

```gjs live preview nebulix
import { PixMonComposant } from '@1024pix/nebulix-ember';

<template><PixMonComposant @label="Enregistrer" /></template>
```

## Une sous-section

Un comportement, une variante... Expliqué, puis illustré par une démo.

```gjs live nebulix
import { PixMonComposant } from '@1024pix/nebulix-ember';

<template><PixMonComposant @label="Enregistrer" @disabled={{true}} /></template>
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/ma-rubrique/pix-mon-composant'
  @name='PixMonComposantSignature'
/>
```
````

- Le **frontmatter** contient :
  - `title: PixMonComposant` : le titre de la page.
  - `new: true` : optionnel, indique si le composant est nouveau (ajouté récemment).
- Le **titre de niveau 1** est le nom du composant, une seule fois dans la page.
- L'**introduction** situe le composant : à quoi il sert.
- **`## Utilisation`** donne l'exemple minimal qui marche.
- Les **sections suivantes** traitent des comportements spécifiques.
- **`## API Docs`** ferme la page.

Pour voir ce squelette rempli, lisez `src/components/graphics/pix-icon.md`.

## Les démos

Une démo est un bloc de code exécuté. Ce sont les mots-clés placés après le langage qui décident de ce qui est affiché.
Ils se combinent, dans n'importe quel ordre.

| mot-clé   | effet                                                                  |
| --------- | ---------------------------------------------------------------------- |
| `live`    | exécute le bloc et affiche le composant rendu                          |
| `preview` | affiche **aussi** le code source, sous le rendu                        |
| `below`   | inverse l'ordre : le code source d'abord, le rendu ensuite             |
| `nebulix` | enveloppe le rendu dans le cadre qui porte les styles du design system |

Sans `live`, le bloc reste un simple bloc de code coloré : rien n'est exécuté.
Sans `nebulix`, la démo s'affiche **sans aucun style Nebulix**.

Une démo peut embarquer ses propres styles pour se mettre en scène en utilisant une balise `<style>` dans le `<template>` :

```gjs nebulix
import { PixIcon } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-icons">
    <PixIcon @name="bell" @ariaHidden={{true}} />
    <PixIcon @name="check" @ariaHidden={{true}} />
  </div>

  <style>
    .demo-icons {
      display: flex;
      gap: 1.5rem;
    }
  </style>
</template>
```

## Le tableau d'API

Le tableau d'API est généré à partir du **JSDoc du composant**. Chaque composant déclare deux `@typedef` en tête de son `.gjs` :

```js
/**
 * @typedef {object} PixIconArgs
 * @property {string} name - Nom de l'icône, tel qu'il figure dans la galerie des icônes. Obligatoire.
 * @property {boolean} [plainIcon] - Affiche la variante pleine de l'icône, quand elle existe.
 */

/**
 * @typedef {object} PixIconSignature
 * @property {SVGSVGElement} Element
 * @property {PixIconArgs} Args
 * @property {{}} Blocks
 */
```

- `PixXxxArgs` liste les arguments, un par `@property`, décrits en français.
  Les crochets marquent l'argument optionnel : `[plainIcon]`.
- `PixXxxSignature` assemble `Element` (le type de l'élément qui reçoit les
  `...attributes`), `Args` et `Blocks` (`{{}}` quand le composant n'a pas de
  bloc).
- Quand un argument est un objet, déclarez un `@typedef` de plus pour lui
  (`PixSelectOption`, `PixStepperStep`…) et référencez-le.

`ember-tsc` transforme ce JSDoc en fichier de types dans `declarations/`, et
ensuite vous pouvez l'afficher dans votre page via `<ComponentSignature>` :

````md
```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/graphics/pix-icon'
  @name='PixIconSignature'
/>
```
````

- `@package` est toujours `@1024pix/nebulix-ember`.
- `@module` est le chemin du fichier de types, **sans extension** : reprenez le
  chemin du composant en remplaçant `src/` par `declarations/`.
- `@name` est le nom du `@typedef` de signature.

## Problèmes courants

**J'ai ajouté un fichier `.md`, il n'apparaît pas.**
Le menu est construit une fois au démarrage du serveur. Recharger la page ne
suffit pas : redémarrez `pnpm doc`. Même chose après avoir créé ou modifié un
`meta.jsonc`, ou renommé un fichier. En revanche, éditer le contenu d'une page
existante est pris en compte à chaud.

**J'ai modifié le JSDoc, le tableau d'API ne bouge pas.**
Le tableau est lu une seule fois, au chargement de la page. Rechargez-la - mais
attendez d'abord que `ember-tsc` ait fini : dans la sortie de `pnpm doc`,
la ligne `[types] Found 0 errors` signale que `declarations/` est à jour. Un
rechargement fait trop tôt ré-affiche l'ancienne version.

**Ma démo s'affiche sans aucun style.**
Il manque le mot-clé `nebulix` sur le bloc.

**Le tableau d'API est vide, ou la page plante.**
Le `@module` ou le `@name` ne correspond à rien. Un `@module` erroné lève une
erreur visible dans la console (`Could not find module by name: …`) ; un `@name`
erroné, lui, n'affiche rien du tout. Vérifiez que le fichier existe bien dans
`declarations/` - s'il n'y est pas, c'est que le composant n'est pas encore
compilé, ou que `ember-tsc` a échoué.
