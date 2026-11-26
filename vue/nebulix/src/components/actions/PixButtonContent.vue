<script setup lang="ts">
import PixIcon from '../graphics/PixIcon.vue';

export interface PixButtonContentProps {
  /** Nom d'une icône affichée avant le contenu. */
  iconBefore?: string;
  /** Nom d'une icône affichée après le contenu. */
  iconAfter?: string;
  /** Affiche `iconBefore` dans sa variante pleine. */
  plainIconBefore?: boolean;
  /** Affiche `iconAfter` dans sa variante pleine. */
  plainIconAfter?: boolean;
}

defineProps<PixButtonContentProps>();
defineSlots<{ default?(): unknown }>();
</script>

<template>
  <PixIcon
    v-if="iconBefore"
    class="pix-button__icon pix-button__icon--before"
    aria-hidden
    :name="iconBefore"
    :plain-icon="plainIconBefore"
  />
  <slot />
  <PixIcon
    v-if="iconAfter"
    class="pix-button__icon pix-button__icon--after"
    aria-hidden
    :name="iconAfter"
    :plain-icon="plainIconAfter"
  />
</template>
