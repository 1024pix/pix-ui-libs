---
title: Ajouter une icône
---

# Ajouter une icône

Les icônes sont fournies par l'équipe Design. Les ajouter à la lib tient en
trois étapes : poser les fichiers dans les sources, régénérer le sprite, puis
déclarer le nom public de l'icône.

La même procédure sert à remplacer une icône ou à en supprimer une.

## 1. Copier les fichiers fournis par le design

Poser les `.svg` dans `ember/nebulix/tooling/generate-svg-sprite/icons`, en
gardant le nommage du design :

```
maNouvelleIcone-fill_false.svg   contour
maNouvelleIcone-fill_true.svg    plein
```

Le design fournit toujours les deux variantes. Ne copier `fill_true` que si la
variante pleine est réellement utilisée : c'est elle qui rend `@plainIcon`
disponible, et chaque variante inutile alourdit le sprite chargé par toutes les
applications.

## 2. Régénérer le sprite

Depuis `ember/nebulix` :

```bash
pnpm svg:generate-sprite
```

La commande réécrit `src/assets/svg/pix-sprite.svg`, dans lequel chaque icône
porte l'id `<nom>` pour le contour et `<nom>_plain` pour le plein.

## 3. Déclarer l'icône

Ajouter une entrée dans `src/helpers/icons.js` : c'est elle qui donne à l'icône
le nom attendu par `@name`.

```js
accountOff: { default: 'accountOff', plainIcon: 'accountOff_plain' },
add: { default: 'add' },
```

`plainIcon` n'est renseigné que si la variante pleine a été ajoutée à l'étape 1.

La clé reprend le nom du fichier. Quelques entrées existantes en divergent
(`arrowBottom` pointe sur `arrowDown`) : c'est historique, il n'y a pas de
raison d'en créer de nouvelles.

## 4. Vérifier dans la galerie

Depuis la racine du dépôt :

```bash
pnpm doc
```

L'icône apparaît dans **Design tokens › Icônes**. La galerie est construite à
partir de `ICONS` : il n'y a aucune page de documentation à modifier.

## 5. Ajouter un changeset

Ajouter un changeset avec `pnpm changeset`, sans quoi la modification ne sera
pas publiée. Voir la page [Publier une version](/nebulix/developpement/release.md).
