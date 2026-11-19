<script setup lang="ts">
import { PixButton } from '@1024pix/nebulix-vue';

// Le bouton affiche son chargeur tant que la promesse n'est pas résolue.
const enregistrer = () => new Promise((resolve) => setTimeout(resolve, 2000));
</script>

<template>
  <PixButton :trigger-action="enregistrer">Enregistrer</PixButton>
</template>
