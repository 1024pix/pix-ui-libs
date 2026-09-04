import { warn } from '@ember/debug';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { guidFor } from '@ember/object/internals';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import PixTag from '../data-display/pix-tag.gjs';
import PixIcon from '../graphics/pix-icon.gjs';

/**
 * @typedef {object} PixAccordionsArgs
 * @property {boolean} [isExpanded] - Passe le composant en mode contrôlé : le parent décide si l'accordéon est déplié, et le composant ne s'ouvre plus de lui-même au clic.
 * @property {(isExpanded: boolean) => unknown} [onToggle] - Appelée à chaque clic sur le titre, avec l'état attendu par l'utilisateur. Son absence déclenche un avertissement : le mode non contrôlé est déprécié.
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

  @tracked isCollapsedWhenUncontrolled = true;
  hasBeenExpandedOnce = false;

  constructor(...args) {
    super(...args);

    warn(
      'PixAccordions: uncontrolled mode is deprecated, use @isExpanded and @onToggle instead',
      Boolean(this.args.onToggle),
      {
        id: 'pix-ui.pix-accordions.uncontrolled.deprecated',
      },
    );
  }

  get isControlled() {
    return this.args.isExpanded !== undefined && this.args.isExpanded !== null;
  }

  get isExpanded() {
    return this.isControlled ? Boolean(this.args.isExpanded) : !this.isCollapsedWhenUncontrolled;
  }

  get isContentRendered() {
    if (this.isExpanded) {
      // eslint-disable-next-line ember/no-side-effects
      this.hasBeenExpandedOnce = true;
    }

    return this.hasBeenExpandedOnce;
  }

  @action
  toggleAccordions() {
    const nextIsExpanded = !this.isExpanded;

    if (!this.isControlled) {
      this.isCollapsedWhenUncontrolled = !nextIsExpanded;
    }

    if (this.args.onToggle) {
      this.args.onToggle(nextIsExpanded);
    }
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
        aria-expanded={{if this.isExpanded "true" "false"}}
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
            @name="{{if this.isExpanded 'chevronTop' 'chevronBottom'}}"
          />
        </span>
      </button>

      <div
        id={{this.contentId}}
        class="pix-accordions{{this.isV2Version}}__content"
        aria-hidden={{if this.isExpanded "false" "true"}}
      >
        {{#if this.isContentRendered}}
          {{yield to="content"}}
        {{/if}}
      </div>
    </div>
  </template>
}
