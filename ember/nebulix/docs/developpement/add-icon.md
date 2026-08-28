---
title: Ajouter une icône
---

# Ajouter une icône

Les icônes sont fournies par l'équipe Design. Il faut générer le sprite et déclarer l'icône pour qu'elle soit disponible via `PixIcon`.

La procédure suivante permet d'ajouter, de remplacer ou de supprimer une icône.

## 1. Copier les fichiers fournis par le design

Poser les `.svg` dans `ember/nebulix/tooling/generate-svg-sprite/icons`, en
gardant le nommage du design :

```sh
maNouvelleIcone-fill_false.svg   # contour
maNouvelleIcone-fill_true.svg    # plein
```

Ne copier `fill_true` que si la variante pleine est réellement utilisée, chaque variante inutile alourdit le sprite chargé par toutes les applications.

## 2. Régénérer le sprite

Depuis `ember/nebulix` :

```bash
pnpm svg:generate-sprite
```

La commande réécrit `src/assets/svg/pix-sprite.svg`.

## 3. Déclarer l'icône

Ajouter une entrée dans `src/helpers/icons.js` : c'est elle qui donne à l'icône le nom attendu par `@name` et reprend le nom du fichier.

```js
accountOff: { default: 'accountOff', plainIcon: 'accountOff_plain' },
add: { default: 'add' },
```

## 4. Vérifier dans la galerie

Depuis la racine du dépôt :

```bash
pnpm doc
```

L'icône apparaît dans **Design tokens › Icônes**.
