<script setup lang="ts">
import { PixButton, type PixButtonVariant } from '@1024pix/nebulix-vue';

defineProps<{ dark?: boolean }>();

const noop = () => {};

const LIGHT: [PixButtonVariant, string][] = [
  ['primary', 'Enregistrer'],
  ['primary-bis', 'Enregistrer'],
  ['secondary', 'Annuler'],
  ['tertiary', 'En savoir plus'],
  ['success', "Valider l'inscription"],
  ['error', 'Supprimer le compte'],
];

const DARK: [PixButtonVariant, string][] = [
  ['primary-white', 'Commencer'],
  ['secondary-white', 'Annuler'],
  ['tertiary-white', 'En savoir plus'],
  ['transparent-dark', 'Continuer'],
];
</script>

<template>
  <div :class="['demo-variants', { 'demo-variants--dark': dark }]">
    <figure v-for="[variant, label] in dark ? DARK : LIGHT" :key="variant">
      <PixButton
        :variant="variant"
        :is-border-visible="variant === 'transparent-dark'"
        :trigger-action="noop"
      >
        {{ label }}
      </PixButton>
      <figcaption>{{ variant }}</figcaption>
    </figure>
  </div>
</template>

<style scoped>
.demo-variants {
  display: flex;
  flex-wrap: wrap;
  gap: 1.5rem;
  align-items: flex-start;
}

.demo-variants--dark {
  padding: 1.5rem;
  background-color: var(--pix-primary-500);
  border-radius: 8px;
}

figure {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  align-items: center;
  margin: 0;
}

figcaption {
  color: var(--pix-neutral-500);
  font-size: 0.8rem;
  font-family: monospace;
}

.demo-variants--dark figcaption {
  color: var(--pix-neutral-0);
}
</style>
