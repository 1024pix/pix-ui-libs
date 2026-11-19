<script setup lang="ts">
import { computed, inject, useId, warn } from 'vue';

import { ICONS } from '../../helpers/icons';
import { ASSETS_URL_KEY, DEFAULT_ASSETS_URL } from '../../plugin';

export interface PixIconProps {
  /** Nom de l'icône, tel qu'il figure dans la galerie des icônes. */
  name: string;
  /** Affiche la variante pleine de l'icône, quand elle existe. */
  plainIcon?: boolean;
  /**
   * Description de l'icône, lue par les lecteurs d'écran. À renseigner lorsque
   * l'icône porte une information qu'aucun texte voisin ne donne.
   */
  title?: string;
  /** Masque l'icône aux lecteurs d'écran. À poser sur toute icône purement décorative. */
  ariaHidden?: boolean;
}

const props = defineProps<PixIconProps>();

const assetsUrl = inject(ASSETS_URL_KEY, DEFAULT_ASSETS_URL);
const titleId = useId();

const symbolId = computed(() => {
  const icon = ICONS[props.name];

  if (!icon) {
    warn(`PixIcon: name "${props.name}" is not one of these: ${Object.keys(ICONS).join(' | ')}`);
    return null;
  }

  return props.plainIcon && icon.plainIcon ? icon.plainIcon : icon.default;
});
</script>

<template>
  <svg
    xmlns="http://www.w3.org/2000/svg"
    role="img"
    class="pix-icon"
    :aria-hidden="ariaHidden ? 'true' : undefined"
    :aria-describedby="title ? titleId : undefined"
  >
    <title v-if="title" :id="titleId">{{ title }}</title>
    <use :href="`${assetsUrl}/svg/pix-sprite.svg#${symbolId}`" />
  </svg>
</template>
