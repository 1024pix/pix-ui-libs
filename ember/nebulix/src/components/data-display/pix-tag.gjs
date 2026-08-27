import Component from '@glimmer/component';

import { formatMessage } from '../../translations/index.js';
import PixIconButton from '../actions/pix-icon-button.gjs';

/**
 * @typedef {object} PixTagArgs
 * @property {'neutral' | 'secondary' | 'tertiary' | 'success' | 'error' | 'orga' | 'blue' | 'blue-light' | 'green' | 'green-light' | 'yellow' | 'yellow-light' | 'orange' | 'orange-light' | 'purple' | 'purple-light' | 'grey' | 'grey-light' | 'dark' | 'white'} [color] - Couleur de l'étiquette.
 * @property {boolean} [displayRemoveButton] - Ajoute un bouton de suppression à droite du texte.
 * @property {(event: MouseEvent) => unknown} [onRemove] - Appelée au clic sur le bouton de suppression.
 * @property {'fr' | 'en' | 'es' | 'es-419' | 'nl'} [locale] - Langue du libellé du bouton de suppression, lu par les lecteurs d'écran. Par défaut : `fr`.
 */

/**
 * @typedef {object} PixTagSignature
 * @property {HTMLDivElement} Element
 * @property {PixTagArgs} Args
 * @property {{ default: [] }} Blocks
 */

export default class PixTag extends Component {
  get classes() {
    const { color } = this.args;
    const classes = [];
    if (color) classes.push(`pix-tag--${color}`);
    return classes.join(' ');
  }

  get ariaLabel() {
    return formatMessage(this.args.locale || 'fr', 'tag.removeButton');
  }

  <template>
    <div class="pix-tag {{this.classes}}" ...attributes>
      {{yield}}
      {{#if @displayRemoveButton}}
        <PixIconButton
          @ariaLabel={{this.ariaLabel}}
          @iconName="close"
          @size="xsmall"
          @triggerAction={{@onRemove}}
        />
      {{/if}}
    </div>
  </template>
}
