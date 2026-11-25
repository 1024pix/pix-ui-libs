---
title: Ajouter une icône
---

# Ajouter une icône

Les icônes sont fournies par l'équipe Design. Chaque icône a son propre dossier, dont le nom est celui attendu par `@name` : le sprite et la liste des icônes (`ICONS`) sont générés à partir de ces dossiers.

La procédure suivante permet d'ajouter, de remplacer ou de supprimer une icône.

## 1. Créer le dossier de l'icône

Dans `core/nebulix-styles/tooling/generate-svg-sprite/icons`, créer un dossier au nom de l'icône et y poser les `.svg` fournis par le design, renommés :

```sh
maNouvelleIcone/
├── default.svg   # contour (fichier `-fill_false` du design)
└── plain.svg     # plein (fichier `-fill_true` du design), optionnel
```

Ne poser `plain.svg` que si la variante pleine est réellement utilisée, chaque variante inutile alourdit le sprite chargé par toutes les applications.

Pour supprimer une icône, supprimer son dossier ; pour la renommer, renommer son dossier.

## 2. Régénérer le sprite et la liste des icônes

Ils ne sont pas versionnés : ils sont générés dans `core/nebulix-styles/dist/` (`svg/pix-sprite.svg` et `icons.js`) à chaque build de `@1024pix/nebulix-ember` (`pnpm build` ou `pnpm dev`), qui les embarque ensuite.

Pour les régénérer seuls, depuis `core/nebulix-styles` :

```bash
pnpm build
```

L'icône est alors disponible via `<PixIcon @name="maNouvelleIcone" />` (et `@plainIcon={{true}}` si `plain.svg` existe).

## 3. Ajouter un changeset

`@1024pix/nebulix-styles` n'est pas publié : ajouter un changeset sur `@1024pix/nebulix-ember` (`pnpm changeset`) pour livrer l'icône.

## 4. Vérifier dans la galerie

Depuis la racine du dépôt :

```bash
pnpm doc
```

L'icône apparaît dans **Design tokens › Icônes**.
