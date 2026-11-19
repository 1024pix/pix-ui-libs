# Pix Nebulix Vue

Nebulix Vue est l'implémentation Vue 3 du design system de Pix.

# Installation

```bash
pnpm add @1024pix/nebulix-vue
```

Dans `vite.config.ts`, le plugin `nebulix()` ajoute les styles Sass aux `loadPaths` et sert les polices et le sprite d'icônes sous `/@1024pix/nebulix-vue/…` :

```ts
import vue from '@vitejs/plugin-vue';
import { nebulix } from '@1024pix/nebulix-vue/vite';
import { defineConfig } from 'vite';

export default defineConfig({
  plugins: [vue(), nebulix()],
});
```

Dans la feuille de style de l'application :

```scss
@use 'nebulix-styles';
```

Puis dans les composants :

```vue
<script setup lang="ts">
import { PixButton } from '@1024pix/nebulix-vue';
</script>

<template>
  <PixButton :trigger-action="save">Enregistrer</PixButton>
</template>
```

Si les polices et le sprite sont servis ailleurs (CDN…), il faut le déclarer à la fois côté Sass et côté Vue :

```scss
@use 'nebulix-styles' with (
  $nebulix-assets-url: 'https://cdn.example.com/nebulix'
);
```

```ts
import { createNebulix } from '@1024pix/nebulix-vue';

app.use(createNebulix({ assetsUrl: 'https://cdn.example.com/nebulix' }));
```

# Développer dans la librairie

```bash
git clone https://github.com/1024pix/pix-ui-libs.git
cd pix-ui-libs
pnpm install
pnpm dev:vue   # build de la librairie en watch + tests en watch
pnpm doc:vue   # build de la librairie en watch + documentation
```
