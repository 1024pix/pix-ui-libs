import { on } from '@ember/modifier';
import { action } from '@ember/object';
import Component from '@glimmer/component';

import modalDialog from '../../modifiers/modal-dialog.js';

/**
 * @typedef {object} PixOverlayArgs
 * @property {boolean} [isVisible] - Ouvre la surcouche.
 * @property {(event: Event) => unknown} [onClose] - Appelée à chaque demande de fermeture : clic sur le fond, touche Échap, fermeture native. Sans elle, la surcouche ne peut pas être refermée par l'utilisateur.
 * @property {boolean} [hasCenteredContent] - Centre le contenu dans la fenêtre.
 * @property {HTMLElement | string} [focusOnClose] - Élément à qui rendre le focus à la fermeture. Par défaut, il revient à l'élément qui avait ouvert la surcouche.
 * @property {string} [labelledBy] - Identifiant de l'élément qui intitule la surcouche.
 * @property {string} [describedBy] - Identifiant de l'élément qui la décrit.
 */

/**
 * @typedef {object} PixOverlaySignature
 * @property {HTMLDialogElement} Element
 * @property {PixOverlayArgs} Args
 * @property {{ default: [] }} Blocks
 */

export default class PixOverlay extends Component {
  @action
  onClick(event) {
    const isClickOnOverlay = event.target.classList.contains('pix-overlay');

    if (this.args.onClose && isClickOnOverlay) {
      this.args.onClose(event);
    }
  }

  /**
   * A `<dialog>` cancel does not bubble, unlike an `<input type="file">` one when its picker is
   * dismissed. Without `onClose`, the default action is kept so the user is not trapped inside.
   */
  @action
  onCancel(event) {
    const isCloseRequestOnOverlay = event.target === event.currentTarget;

    if (!isCloseRequestOnOverlay || !this.args.onClose) {
      return;
    }

    event.preventDefault();
    this.args.onClose(event);
  }

  @action
  onDialogClose(event) {
    if (this.args.isVisible && this.args.onClose) {
      this.args.onClose(event);
    }
  }

  <template>
    <dialog
      class="pix-overlay {{if @hasCenteredContent ' pix-overlay--with-centered-content'}}"
      aria-labelledby={{@labelledBy}}
      aria-describedby={{@describedBy}}
      {{on "click" this.onClick}}
      {{on "cancel" this.onCancel}}
      {{on "close" this.onDialogClose}}
      {{modalDialog @isVisible @focusOnClose}}
      ...attributes
    >
      {{yield}}
    </dialog>
  </template>
}
