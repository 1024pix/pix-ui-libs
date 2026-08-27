import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { guidFor } from '@ember/object/internals';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import PixTag from '../data-display/pix-tag.gjs';
import PixIcon from '../graphics/pix-icon.gjs';

/**
 * @typedef {object} PixAccordionsArgs
 * @property {string} [iconName] - Nom d'une icône affichée avant le titre.
 * @property {boolean} [plainIcon] - Affiche `iconName` dans sa variante pleine.
 * @property {string} [tagContent] - Texte d'une étiquette affichée à droite du titre.
 * @property {string} [tagColor] - Couleur de cette étiquette, au sens de `PixTag`.
 * @property {boolean} [isV2Version] - Applique le jeu de styles de deuxième génération.
 */

/**
 * @typedef {object} PixAccordionsSignature
 * @property {HTMLButtonElement} Element
 * @property {PixAccordionsArgs} Args
 * @property {{ title: [], content: [] }} Blocks
 */

export default class PixAccordions extends Component {
  text = 'pix-accordions';
  contentId = 'pix-accordions-' + guidFor(this);

  @tracked isCollapsed = true;
  @tracked hasUnCollapsedOnce = false;

  get isUnCollapsed() {
    return !this.isCollapsed;
  }

  get isContentRendered() {
    return this.hasUnCollapsedOnce;
  }

  @action
  toggleAccordions() {
    this.isCollapsed = !this.isCollapsed;
    this.hasUnCollapsedOnce = true;
  }

  get isV2Version() {
    return this.args.isV2Version ? '-v2' : '';
  }

  <template>
    <div class="pix-accordions{{this.isV2Version}}">

      <button
        class="pix-accordions{{this.isV2Version}}__title"
        type="button"
        {{on "click" this.toggleAccordions}}
        aria-controls={{this.contentId}}
        aria-expanded={{if this.isUnCollapsed "true" "false"}}
        ...attributes
      >

        <span class="pix-accordions{{this.isV2Version}}-title__container">
          {{#if @iconName}}
            <PixIcon
              class="pix-accordions{{this.isV2Version}}-title__icon"
              @name={{@iconName}}
              @plainIcon={{@plainIcon}}
              @ariaHidden={{true}}
            />
          {{/if}}

          {{yield to="title"}}
        </span>

        <span class="pix-accordions{{this.isV2Version}}-title__container">
          {{#if @tagContent}}
            <PixTag @color={{@tagColor}}>
              {{@tagContent}}
            </PixTag>
          {{/if}}
          <PixIcon
            class="pix-accordions{{this.isV2Version}}-title-container__toggle-icon"
            @ariaHidden={{true}}
            @name="{{if this.isCollapsed 'chevronBottom' 'chevronTop'}}"
          />
        </span>
      </button>

      <div
        id={{this.contentId}}
        class="pix-accordions{{this.isV2Version}}__content"
        aria-hidden={{if this.isCollapsed "true" "false"}}
      >
        {{#if this.isContentRendered}}
          {{yield to="content"}}
        {{/if}}
      </div>
    </div>
  </template>
}
