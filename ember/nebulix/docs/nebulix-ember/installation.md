---
title: Getting Started
---

# Installer Nebulix Ember

Guide d'installation et d'utilisation de `@1024pix/nebulix-ember` dans une application Ember.

## Installer l'addon

```bash
  npm install -D @1024pix/nebulix-ember@<version>
```

## Ember avec Webpack

Ajouter dans `ember-cli-build.js` :

```js
// ember-cli-build.js
sassOptions: {
  includePaths: ['node_modules/@1024pix/nebulix-ember/dist/styles'],
},
```

## Ember avec Vite

Ajouter dans `vite.config.js` :

```js
// vite.config.js
css: {
  preprocessorOptions: {
    scss: {
      api: 'modern',
      loadPaths: ['node_modules/@1024pix/nebulix-ember/dist/styles'],
    },
  },
},
```

## Ajouter les styles

Charger les styles explicitement, **en premier** dans `app/styles/app.scss` :

```css
@use 'nebulix-styles' as *;

/* les styles de l'application ensuite */
```

## Utiliser un composant

Pour utiliser un composant, importez-le dans votre app Ember comme n'importe quel autre composant.

```gjs preview
import { PixButton } from '@1024pix/nebulix-ember';

<template>
  <PixButton>
    Enregistrer
  </PixButton>
</template>
```
