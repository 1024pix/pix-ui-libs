<script setup lang="ts">
import { PixButton } from '@1024pix/nebulix-vue';

const construire = () => {};
</script>

<template>
  <PixButton :trigger-action="construire" icon-before="brick" plain-icon-before icon-after="brick">
    Construire
  </PixButton>
</template>
