import PixIcon from '../graphics/pix-icon.gjs';

/**
 * @typedef {object} PixButtonContentArgs
 * @property {string} [iconBefore] - Nom d'une icône affichée avant le contenu.
 * @property {string} [iconAfter] - Nom d'une icône affichée après le contenu.
 * @property {boolean} [plainIconBefore] - Affiche `iconBefore` dans sa variante pleine.
 * @property {boolean} [plainIconAfter] - Affiche `iconAfter` dans sa variante pleine.
 */

/**
 * @typedef {object} PixButtonContentSignature
 * @property {null} Element
 * @property {PixButtonContentArgs} Args
 * @property {{ default: [] }} Blocks
 */

<template>
  {{#if @iconBefore}}
    <PixIcon
      class="pix-button__icon pix-button__icon--before"
      @ariaHidden={{true}}
      @name={{@iconBefore}}
      @plainIcon={{@plainIconBefore}}
    />
  {{/if}}
  {{yield}}
  {{#if @iconAfter}}
    <PixIcon
      class="pix-button__icon pix-button__icon--after"
      @name={{@iconAfter}}
      @ariaHidden={{true}}
      @plainIcon={{@plainIconAfter}}
    />
  {{/if}}
</template>
