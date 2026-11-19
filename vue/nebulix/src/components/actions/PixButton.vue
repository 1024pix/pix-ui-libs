<script setup lang="ts">
import { computed, ref, warn } from 'vue';

import PixButtonContent from './PixButtonContent.vue';

export type PixButtonVariant =
  | 'primary'
  | 'primary-white'
  | 'primary-bis'
  | 'secondary'
  | 'secondary-white'
  | 'tertiary'
  | 'tertiary-white'
  | 'success'
  | 'error'
  | 'transparent-dark';

export interface PixButtonProps {
  /** Rôle du bouton dans la page, qui détermine ses couleurs. */
  variant?: PixButtonVariant;
  /** Hauteur et espacements du bouton. */
  size?: 'small' | 'large';
  /** Type natif du bouton. */
  type?: 'button' | 'submit' | 'reset';
  /**
   * Appelée au clic. Tant que la promesse retournée n'est pas résolue, le bouton
   * affiche son chargeur et refuse les clics suivants. Obligatoire, sauf si
   * `type` vaut `submit`.
   */
  triggerAction?: (event: MouseEvent) => unknown;
  /** Force l'état de chargement, indépendamment de `triggerAction`. */
  isLoading?: boolean;
  /**
   * Couleur du chargeur. `current` reprend la couleur du texte du bouton.
   * Par défaut : `current` pour la variante `tertiary`, `white` sinon.
   */
  loadingColor?: 'white' | 'grey' | 'current';
  /** Désactive le bouton. Il reste focusable et porte `aria-disabled="true"`. */
  isDisabled?: boolean;
  /** Ajoute une bordure. N'a d'effet qu'avec la variante `transparent-dark`. */
  isBorderVisible?: boolean;
  /** Nom d'une icône affichée avant le libellé. */
  iconBefore?: string;
  /** Nom d'une icône affichée après le libellé. */
  iconAfter?: string;
  /** Affiche `iconBefore` dans sa variante pleine. */
  plainIconBefore?: boolean;
  /** Affiche `iconAfter` dans sa variante pleine. */
  plainIconAfter?: boolean;
}

const props = withDefaults(defineProps<PixButtonProps>(), {
  variant: 'primary',
  size: 'small',
  type: 'button',
  triggerAction: undefined,
  loadingColor: undefined,
  iconBefore: undefined,
  iconAfter: undefined,
});

defineSlots<{ default?(): unknown }>();

if (props.type !== 'submit' && typeof props.triggerAction !== 'function') {
  warn('PixButton: triggerAction should be a function, unless type is "submit".');
}

const isTriggering = ref(false);

const isLoading = computed(() => props.isLoading || isTriggering.value);
const isDisabled = computed(() => isLoading.value || props.isDisabled);

const loaderColor = computed(
  () => props.loadingColor ?? (props.variant === 'tertiary' ? 'current' : 'white'),
);

const classNames = computed(() => [
  'pix-button',
  `pix-button--size-${props.size}`,
  `pix-button--${props.variant}`,
  { 'pix-button--border': props.isBorderVisible },
]);

async function onClick(event: MouseEvent) {
  if (isDisabled.value) {
    // `aria-disabled` keeps the button focusable but does not stop a native
    // submit or reset: do it here.
    event.preventDefault();
    return;
  }

  // Without an action, a submit button falls back to native form submission.
  if (!props.triggerAction) return;

  try {
    isTriggering.value = true;
    await props.triggerAction(event);
  } finally {
    isTriggering.value = false;
  }
}
</script>

<template>
  <button
    :type="type"
    :class="classNames"
    :aria-disabled="isDisabled ? 'true' : undefined"
    @click="onClick"
  >
    <template v-if="isLoading">
      <div :class="['loader', `loader--${loaderColor}`]">
        <div class="bounce1"></div>
        <div class="bounce2"></div>
        <div class="bounce3"></div>
      </div>
      <span class="loader__not-visible-text"><slot /></span>
    </template>
    <PixButtonContent
      v-else
      :icon-before="iconBefore"
      :icon-after="iconAfter"
      :plain-icon-before="plainIconBefore"
      :plain-icon-after="plainIconAfter"
    >
      <slot />
    </PixButtonContent>
  </button>
</template>
