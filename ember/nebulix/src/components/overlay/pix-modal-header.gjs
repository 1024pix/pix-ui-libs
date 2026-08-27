import Component from '@glimmer/component';

import { MODAL_VARIANTS } from '../../helpers/variants.js';
import PixIconButton from '../actions/pix-icon-button.gjs';
import PixIcon from '../graphics/pix-icon.gjs';

/**
 * @typedef {object} PixModalHeaderArgs
 * @property {string} title - Titre, rendu dans un `<h1>`. Obligatoire.
 * @property {string} [id] - Identifiant du titre, sur lequel s'appuie l'intitulé de la surcouche.
 * @property {string} [subtitle] - Précision affichée sous le titre.
 * @property {string} [iconName] - Nom d'une icône affichée à gauche du titre.
 * @property {boolean} [plainIcon] - Affiche cette icône dans sa variante pleine.
 * @property {'default' | 'orga' | 'certif'} [variant] - Application à laquelle l'en-tête appartient, qui détermine ses couleurs. Par défaut : `default`.
 * @property {(event: MouseEvent) => unknown} [onCloseButtonClick] - Appelée au clic sur le bouton de fermeture.
 */

/**
 * @typedef {object} PixModalHeaderSignature
 * @property {HTMLDivElement} Element
 * @property {PixModalHeaderArgs} Args
 * @property {{}} Blocks
 */

export default class PixModalHeader extends Component {
  get variant() {
    if (this.args.variant && !MODAL_VARIANTS.includes(this.args.variant)) {
      throw new Error(
        `ERROR in PixModalHeader component: @variant should be one of ${MODAL_VARIANTS.join(', ')}`,
      );
    }

    const value = this.args.variant ?? 'default';

    return value;
  }

  <template>
    <div class="pix-modal-header pix-modal-header--{{this.variant}}" ...attributes>
      <section class="pix-modal-header__title-section">
        {{#if @iconName}}
          <div
            class="pix-modal-header__icon-container pix-modal-header__icon-container--{{this.variant}}"
          >
            <PixIcon @name={{@iconName}} @plainIcon={{@plainIcon}} @ariaHidden={{true}} />
          </div>
        {{/if}}
        <div>
          <h1 id={{@id}} class="pix-modal-header__title">{{@title}}</h1>
          {{#if @subtitle}}
            <p title={{@subtitle}} class="pix-modal-header__subtitle">{{@subtitle}}</p>
          {{/if}}
        </div>

      </section>

      <PixIconButton
        @iconName="close"
        @triggerAction={{@onCloseButtonClick}}
        @ariaLabel="Fermer"
        @size="small"
        @withBackground={{true}}
        class="pix-modal-header__close-button"
      />
    </div>
  </template>
}
