---
title: Publier une version
---

# Publier une version

Les versions de `@1024pix/nebulix-ember` sont gérées avec
[changesets](https://changesets.dev). Vous décrivez votre modification dans un
changeset ; le numéro de version, le changelog et la publication sur npm sont
automatiques.

## Les étapes

1. Modifier la lib — voir la page <a href="/nebulix/developpement/create-component.md">Créer un composant</a>.
2. Ajouter un changeset avec `pnpm changeset`, dans la même PR.
3. Merger la PR : une PR **Version Packages** est ouverte, ou mise à jour si elle existe déjà.
4. Merger la PR **Version Packages** : la version est publiée sur npm et le changelog mis à jour.

## Quand ajouter un changeset

Dès que le contenu publié sur npm change, c'est-à-dire dès que vous touchez à
`ember/nebulix/src/`, aux dépendances du package ou à sa configuration de build.

Pas de changeset pour ce qui ne part pas dans le paquet : `docs-app`,
`test-app`, les tests, la CI, les pages de documentation, le lint et le
formatage.

Une page de documentation corrigée seule ne déclenche donc pas de publication.
Modifiée en même temps qu'un composant, elle est couverte par le changeset de ce
composant.

Dans le doute, ajoutez-en un : une version de patch de trop ne coûte rien.

## Ajouter un changeset

```sh
pnpm changeset
```

La commande pose trois questions : **quel package** est concerné
(`@1024pix/nebulix-ember`), **quel niveau** de version (voir plus bas), et
**quel message**, qui apparaîtra tel quel dans le changelog.

Elle écrit un fichier au nom généré dans `.changeset/`, et le committe
elle-même : il n'y a pas de `git add` à faire.

```markdown
---
'@1024pix/nebulix-ember': minor
---

Ajouter l'argument `@condensed` à `PixBlock`
```

## Choisir le niveau

| Niveau  | Quand                            | Exemple                                            |
| ------- | -------------------------------- | -------------------------------------------------- |
| `patch` | correction sans changement d'API | corriger l'alignement d'un composant               |
| `minor` | ajout rétrocompatible            | nouveau composant, nouvel argument optionnel       |
| `major` | changement incompatible          | argument renommé ou supprimé, comportement modifié |

Plusieurs changesets peuvent s'accumuler avant une publication : c'est le niveau
le plus élevé qui l'emporte.

Tant que la lib est en `0.x`, un `major` la fait passer en `1.0.0` : ne le
choisissez pas sans en parler à l'équipe.

## Ce qui se passe ensuite

**Sur votre PR**, un bot commente si elle contient un changeset ou non. Le
commentaire est indicatif, il ne bloque pas la merge.

**Après la merge sur `dev`**, une PR **Version Packages** est ouverte
automatiquement. Elle consomme les changesets, incrémente la version du package
et met à jour son `CHANGELOG.md`. Chaque nouveau changeset mergé sur `dev` la
met à jour.

**En mergeant la PR Version Packages**, la lib est buildée, publiée sur npm, et
le changelog est figé dans `CHANGELOG.md`. N'importe qui de l'équipe peut la
merger quand une version est attendue : il n'y a pas de cadence imposée.
