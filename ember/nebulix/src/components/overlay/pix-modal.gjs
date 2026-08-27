import { guidFor } from '@ember/object/internals';
import Component from '@glimmer/component';

import { MODAL_VARIANTS } from '../../helpers/variants.js';
import PixModalHeader from './pix-modal-header.gjs';
import PixOverlay from './pix-overlay.gjs';

/**
 * @typedef {object} PixModalArgs
 * @property {string} title - Titre de la modale, rendu dans un `<h1>`. Obligatoire : sans lui, le composant lève une erreur.
 * @property {boolean} [showModal] - Ouvre la modale.
 * @property {(event: Event) => unknown} [onCloseButtonClick] - Appelée à chaque demande de fermeture : bouton de fermeture, clic sur le fond, touche Échap.
 * @property {string} [subtitle] - Précision affichée sous le titre.
 * @property {string} [iconName] - Nom d'une icône affichée à gauche du titre.
 * @property {boolean} [plainIcon] - Affiche cette icône dans sa variante pleine.
 * @property {'default' | 'orga' | 'certif'} [variant] - Application à laquelle la modale appartient, qui détermine ses couleurs. Par défaut : `default`.
 * @property {HTMLElement | string} [focusOnClose] - Élément à qui rendre le focus à la fermeture. Par défaut, il revient à l'élément qui avait ouvert la modale.
 */

/**
 * @typedef {object} PixModalSignature
 * @property {HTMLDivElement} Element
 * @property {PixModalArgs} Args
 * @property {{ content: [], footer: [] }} Blocks
 */

export default class PixModal extends Component {
  constructor(...args) {
    super(...args);

    if (!this.args.title) {
      throw new Error('ERROR in PixModal component: @title argument is required.');
    }
  }

  get id() {
    return guidFor(this);
  }

  get variant() {
    if (this.args.variant && !MODAL_VARIANTS.includes(this.args.variant)) {
      throw new Error(
        `ERROR in PixModal component: @variant should be one of ${MODAL_VARIANTS.join(', ')}`,
      );
    }

    const value = this.args.variant ?? 'default';

    return value;
  }

  <template>
    <PixOverlay
      @isVisible={{@showModal}}
      @onClose={{@onCloseButtonClick}}
      @focusOnClose={{@focusOnClose}}
      @hasCenteredContent={{true}}
      @labelledBy="modal-title--{{this.id}}"
    >
      <div class="pix-modal pix-modal--{{this.variant}}" ...attributes>
        <PixModalHeader
          @id="modal-title--{{this.id}}"
          @title={{@title}}
          @subtitle={{@subtitle}}
          @variant={{this.variant}}
          @iconName={{@iconName}}
          @plainIcon={{@plainIcon}}
          @onCloseButtonClick={{@onCloseButtonClick}}
        />

        <div class="pix-modal__content">
          {{yield to="content"}}
        </div>
        <div class="pix-modal__footer">
          {{yield to="footer"}}
        </div>
      </div>
    </PixOverlay>
  </template>
}
