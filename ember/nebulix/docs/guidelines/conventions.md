---
title: Nommage et conventions
---

# Nommage et conventions

## Nommage

- Les **noms des fichiers** sont écrits en _kebab-case_. Exemple : `pix-select.gjs`

- Les **noms des composants** commencent par `Pix` et sont écrit en _PascalCase_. Exemple : `PixSelect`

- Les **noms des propriétés des composants** sont écrit en _camelCase_. Exemple : `@onChange`

```gjs
// pix-select.gjs
<PixSelect @options={{options}} @onChange={{onChange}} />
```

- Les **noms des classes CSS** suivent la convention [BEM](https://github.com/1024pix/pix/blob/dev/docs/CSS.md).

```html
<div class="pix-select__content"></div>
```

## Conventions

- Toujours utiliser les classes utilitaires ou les variables CSS dans les composants.

- Ne plus utiliser %extends ou de mixin dans le sass (déprécié)

- Ne JAMAIS mettre de traduction dans les composants, mais les passer en arguments dans un attribut `@texts` sous forme d’objet clé-valeur.

- Dans Nebulix ember, on doit importer les lib externes dans dependencies (pas devDependencies)

- Ajouter une dépendance (librairie) a des impacts très important pour les frontends (taille du bundle, performances, maintenance…). Faire très attention avant d’en ajouter une et valider avec les autres équipes.

## Intentions & Responsabilités

Il faut garder une **responsabilité unique** par composant.

- Un composant doit interagir uniquement dans son scope afin de ne pas devenir trop complexe et provoquer des effets de bord.
- Un composant trop complexe induit plusieurs paramètres ce qui rend donc son utilisation délicate.

Par exemple, si l'intention d'un composant est d'être un bouton (dans notre existant, _`PixButton`_) et qu'on le fait évoluer pour qu'il puisse devenir aussi un lien, il perd alors son intention d'origine (le nommage du composant _`PixButton`_ ne fait alors plus sens) et prend trop de responsabilités.

Il conviendra alors d'avoir un composant pour un bouton et un autre pour un lien.

## Rétrocompatibilité / Deprecated

Il est aussi possible de signaler ces changements comme dépréciés :

- Ne pas supprimer le composant actuel mais l'indiquer comme déprécié afin qu'il soit toujours utilisable le temps de faire les modifications. À terme, l'élément déprécié sera supprimé dans une nouvelle version majeure de Pix UI.

Exemple d'un composant déprécié :

```hbs
<PixSelect>
  <NewPixSelect @options={{options}} @onChange={{onChange}} @selectedOption='1' />
</PixSelect>
```
