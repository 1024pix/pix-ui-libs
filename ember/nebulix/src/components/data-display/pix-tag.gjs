import { warn } from '@ember/debug';
import Component from '@glimmer/component';

import PixIconButton from '../actions/pix-icon-button.gjs';

/**
 * @typedef {object} PixTagTexts
 * @property {string} removeButtonLabel - Libellé accessible du bouton de suppression, lu par les lecteurs d'écran. Obligatoire si `onRemove` est fourni.
 */

/**
 * @typedef {object} PixTagArgs
 * @property {'neutral' | 'secondary' | 'tertiary' | 'success' | 'error' | 'orga' | 'blue' | 'blue-light' | 'green' | 'green-light' | 'yellow' | 'yellow-light' | 'orange' | 'orange-light' | 'purple' | 'purple-light' | 'grey' | 'grey-light' | 'dark' | 'white'} [color] - Couleur de l'étiquette.
 * @property {(event: MouseEvent) => unknown} [onRemove] - Appelée au clic sur le bouton de suppression. Ajoute le bouton de suppression lorsqu'elle est fournie.
 * @property {PixTagTexts} [texts] - Textes affichés par le composant. À fournir par l'application consommatrice, dans la langue de son choix.
 */

/**
 * @typedef {object} PixTagSignature
 * @property {HTMLDivElement} Element
 * @property {PixTagArgs} Args
 * @property {{ default: [] }} Blocks
 */

export default class PixTag extends Component {
  constructor(...args) {
    super(...args);
    if (this.args.onRemove) {
      warn(
        'PixTag: texts.removeButtonLabel is mandatory when onRemove is provided  ',
        Boolean(this.args.texts?.removeButtonLabel),
        {
          id: 'pix-ui.pix-tag.texts.mandatory',
        },
      );
    }
  }

  get classes() {
    const { color } = this.args;
    const classes = [];
    if (color) classes.push(`pix-tag--${color}`);
    return classes.join(' ');
  }

  <template>
    <div class="pix-tag {{this.classes}}" ...attributes>
      {{yield}}
      {{#if @onRemove}}
        <PixIconButton
          @ariaLabel={{@texts.removeButtonLabel}}
          @iconName="close"
          @size="xsmall"
          @triggerAction={{@onRemove}}
        />
      {{/if}}
    </div>
  </template>
}
