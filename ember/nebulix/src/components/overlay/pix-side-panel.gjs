import { guidFor } from '@ember/object/internals';
import Component from '@glimmer/component';

import { MODAL_VARIANTS } from '../../helpers/variants.js';
import PixModalHeader from './pix-modal-header.gjs';
import PixOverlay from './pix-overlay.gjs';

/**
 * @typedef {object} PixSidePanelArgs
 * @property {string} title - Titre du panneau, rendu dans un `<h1>`. Obligatoire : sans lui, le composant lève une erreur.
 * @property {boolean} [showSidePanel] - Ouvre le panneau.
 * @property {(event: Event) => unknown} [onClose] - Appelée à chaque demande de fermeture : bouton de fermeture, clic sur le fond, touche Échap.
 * @property {string} [subtitle] - Précision affichée sous le titre.
 * @property {string} [iconName] - Nom d'une icône affichée à gauche du titre.
 * @property {'default' | 'orga' | 'certif'} [variant] - Application à laquelle le panneau appartient, qui détermine ses couleurs. Par défaut : `default`.
 * @property {HTMLElement | string} [focusOnClose] - Élément à qui rendre le focus à la fermeture. Par défaut, il revient à l'élément qui avait ouvert le panneau.
 */

/**
 * @typedef {object} PixSidePanelSignature
 * @property {HTMLDivElement} Element
 * @property {PixSidePanelArgs} Args
 * @property {{ content: [], footer: [] }} Blocks
 */

export default class PixSidePanel extends Component {
  constructor(...args) {
    super(...args);

    if (!this.args.title) {
      throw new Error('ERROR in PixSidePanel component: @title argument is required.');
    }
  }

  get variant() {
    if (this.args.variant && !MODAL_VARIANTS.includes(this.args.variant)) {
      throw new Error(
        `ERROR in PixSidePanel component: @variant should be one of ${MODAL_VARIANTS.join(', ')}`,
      );
    }

    const value = this.args.variant ?? 'default';

    return value;
  }

  get id() {
    return guidFor(this);
  }

  <template>
    <PixOverlay
      class="pix-side-panel__overlay"
      @isVisible={{@showSidePanel}}
      @onClose={{@onClose}}
      @focusOnClose={{@focusOnClose}}
      @labelledBy="side-panel-title--{{this.id}}"
    >
      <div class="pix-side-panel pix-side-panel--{{this.variant}}" ...attributes>
        <PixModalHeader
          class="pix-side-panel__header"
          @id="side-panel-title--{{this.id}}"
          @title={{@title}}
          @subtitle={{@subtitle}}
          @iconName={{@iconName}}
          @variant={{this.variant}}
          @onCloseButtonClick={{@onClose}}
        />

        <div class="pix-side-panel__content">
          {{yield to="content"}}
        </div>
        <div class="pix-side-panel__footer pix-side-panel__footer--{{this.variant}}">
          {{yield to="footer"}}
        </div>
      </div>
    </PixOverlay>
  </template>
}
