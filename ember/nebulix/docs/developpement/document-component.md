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

La documentation est générée avec [Kolay](https://kolay.nullvoxpopuli.com/) et servie sur [http://localhost:4200](http://localhost:4200).

### La version de Kolay

Kolay n'est pas installé depuis npm mais depuis un commit précis du dépôt
GitHub, dans `ember/docs-app/package.json` :

```json
"kolay": "github:universal-ember/kolay#cdbda81a605477020e6720b43488922e2d5d9231"
```

Ce n'est pas un accident. Nous utilisons des API qui ne sont pas encore
publiées - `apiDocs` dans `kolay.config.js`, par exemple, s'appelait encore
`typedoc` dans la dernière version npm. Revenir à `kolay@5.4.0` casserait la
génération de la doc.

Ces commits vivent sur la branche `dist` du dépôt Kolay, où la CI publie le
paquet déjà construit - la branche `main`, elle, n'embarque pas les artefacts
de build et n'est donc pas installable. Cette branche `dist` est **réécrite à
chaque publication** : elle ne porte qu'un seul commit à la fois. Un SHA qu'on
y épingle n'est donc plus référencé dès la publication suivante. GitHub
continue de le servir en pratique, mais rien ne le garantit indéfiniment.

Pour monter de version, prenez le commit de tête de `dist` :

```bash
git ls-remote https://github.com/universal-ember/kolay dist
```

Reportez le SHA dans `package.json`, puis `pnpm install` et vérifiez que
`pnpm --filter docs-app build` et `pnpm --filter docs-app lint:types` passent
toujours.

## Créer la page

Le fichier de documentation porte le nom du composant et vit dans le même
dossier que lui :

```
src/components/graphics/pix-icon.gjs
src/components/graphics/pix-icon.scss
src/components/graphics/pix-icon.md
```

Le **dossier** détermine la rubrique dans laquelle le composant apparaît :
`graphics` devient « Graphics » dans le menu. Le **`title` du frontmatter**
détermine son libellé. Sans lui, on affiche le nom de fichier humanisé
(`pix-icon` → « Pix icon »).

À l'intérieur d'une rubrique, les composants sont classés par ordre
alphabétique.

L'ordre des **rubriques**, lui, est fixé dans `src/components/meta.jsonc` :

```jsonc
{
  "order": ["actions", "content", "data-display", "..."],
}
```

Cette liste doit être **exhaustive** : si vous ajoutez une rubrique (donc un
dossier), ajoutez-la aussi dans `order`, sinon le serveur refuse de construire
le menu.

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

Un comportement, une variante, un choix à faire. Expliqué, puis illustré par une démo.

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

````md
```gjs live nebulix
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
````

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

```

```
