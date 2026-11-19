---
title: Installation
---

# Installer Nebulix Vue

Guide d'installation et d'utilisation de `@1024pix/nebulix-vue` dans une application Vue 3 construite avec Vite.

## Installer la librairie

```bash
npm install @1024pix/nebulix-vue@<version>
```

## Configurer Vite

Le plugin `nebulix()` ajoute les styles Sass aux `loadPaths` et sert les polices et le sprite d'icônes sous `/@1024pix/nebulix-vue/…`, en développement comme au build.

```ts
// vite.config.ts
import { nebulix } from '@1024pix/nebulix-vue/vite';
import vue from '@vitejs/plugin-vue';
import { defineConfig } from 'vite';

export default defineConfig({
  plugins: [vue(), nebulix()],
});
```

Les styles sont écrits en Sass : l'application doit dépendre de `sass-embedded` (ou `sass`).

## Ajouter les styles

Charger les styles explicitement, **en premier** dans la feuille de style de l'application :

```scss
@use 'nebulix-styles';

/* les styles de l'application ensuite */
```

## Utiliser un composant

```vue
<script setup lang="ts">
import { PixButton } from '@1024pix/nebulix-vue';

const enregistrer = async () => {
  // votre action
};
</script>

<template>
  <PixButton :trigger-action="enregistrer">Enregistrer</PixButton>
</template>
```

## Servir les polices et les icônes ailleurs

Si les polices et le sprite d'icônes sont servis à une autre URL (CDN…), copier le contenu de `@1024pix/nebulix-vue/public/` à cet endroit, puis déclarer l'URL à la fois côté Sass et côté Vue :

```scss
@use 'nebulix-styles' with (
  $nebulix-assets-url: 'https://cdn.example.com/nebulix'
);
```

```ts
// main.ts
import { createNebulix } from '@1024pix/nebulix-vue';

app.use(createNebulix({ assetsUrl: 'https://cdn.example.com/nebulix' }));
```
