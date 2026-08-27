---
title: Tester localement
---

# Tester localement

Il est possible de tester les changements de la lib dans une application Ember
sans publier de version sur npm : on construit une archive du package et on
l'installe dans l'application.

## 1. Se placer sur la branche à tester

Dans le dépôt `pix-ui-libs` :

```bash
git checkout <branche>
```

## 2. Créer l'archive

Depuis `ember/nebulix` :

```bash
pnpm pack
```

La commande construit le package puis écrit une archive
`1024pix-nebulix-ember-<version>.tgz` dans `ember/nebulix`.

## 3. Installer l'archive dans l'application

Depuis le répertoire de l'application :

```bash
npm install --save-dev "file:../pix-ui-libs/ember/nebulix/1024pix-nebulix-ember-<version>.tgz"
```

Puis lancer l'application :

```bash
npm run dev
```

## 4. Rejouer après chaque modification

L'archive est un instantané : les modifications faites ensuite sur la lib n'y
sont pas. Comme le numéro de version ne change pas d'une archive à l'autre, il
faut aussi supprimer le package installé, sans quoi l'ancien contenu est
resservi.

```bash
# dans ember/nebulix
pnpm pack

# dans l'application
rm -rf node_modules/@1024pix/nebulix-ember
npm install --save-dev "file:../pix-ui-libs/ember/nebulix/1024pix-nebulix-ember-<version>.tgz"
```

## 5. Revenir à la version publiée

Une fois le test terminé, dans l'application :

```bash
git checkout package.json package-lock.json
npm install
```

Et supprimer l'archive dans `ember/nebulix`.

## Pièges

- **Ne pas committer l'installation locale.** Le `file:` dans `package.json` et
  le lockfile modifié ne doivent pas partir dans la PR de l'application : faire
  l'étape 5 avant de committer.
- **Le chemin du `file:` est relatif à l'application**, pas au répertoire depuis
  lequel la commande est lancée. Adapter `../pix-ui-libs` à l'emplacement réel
  du dépôt.
