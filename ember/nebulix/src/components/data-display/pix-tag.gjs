import { warn } from '@ember/debug';
import Component from '@glimmer/component';

import PixIconButton from '../actions/pix-icon-button.gjs';
import PixIcon from '../graphics/pix-icon.gjs';

/**
 * @typedef {object} PixTagTexts
 * @property {string} removeButtonLabel - Libellé accessible du bouton de suppression, lu par les lecteurs d'écran. Obligatoire si `onRemove` est fourni.
 */

/**
 * @typedef {object} PixTagArgs
 * @property {'neutral' | 'secondary' | 'tertiary' | 'success' | 'success-light' | 'error' | 'error-light' | 'orga' | 'blue' | 'blue-light' | 'green' | 'green-light' | 'yellow' | 'yellow-light' | 'orange' | 'orange-light' | 'purple' | 'purple-light' | 'grey' | 'grey-light' | 'dark' | 'white'} [color] - Couleur de l'étiquette.
 * @property {(event: MouseEvent) => unknown} [onRemove] - Appelée au clic sur le bouton de suppression. Ajoute le bouton de suppression lorsqu'elle est fournie.
 * @property {PixTagTexts} [texts] - Textes affichés par le composant. À fournir par l'application consommatrice, dans la langue de son choix.
 * @property {'squircle'} [type] - Permet de modifier les arrondis du composant
 * @property {string} [iconBefore] - Nom de l'icône à afficher avant le texte
 * @property {string} [iconAfter] - Nom de l'icône à afficher après le texte
 * @property {'small'} [size] - Réduit la taille du texte du tag
 * @property {'uppercase'} [textTransform] - Transforme le texte en MAJUSCULE
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
    const { color, type, textTransform, size } = this.args;
    const classes = [];
    if (size) classes.push(`pix-tag--${size}`);
    if (color) classes.push(`pix-tag--${color}`);
    if (type) classes.push(`pix-tag--${type}`);
    if (textTransform) classes.push(`pix-tag--${textTransform}`);
    return classes.join(' ');
  }

  <template>
    <div class="pix-tag {{this.classes}}" ...attributes>
      {{#if @iconBefore}}
        <PixIcon
          class="pix-tag__icon"
          @name={{@iconBefore}}
          @ariaHidden={{true}}
          @plainIcon={{@plainIcon}}
        />
      {{/if}}
      {{yield}}
      {{#if @onRemove}}
        <PixIconButton
          @ariaLabel={{@texts.removeButtonLabel}}
          @iconName="close"
          @size="xsmall"
          @triggerAction={{@onRemove}}
        />
      {{/if}}
      {{#if @iconAfter}}
        <PixIcon
          class="pix-tag__icon"
          @name={{@iconAfter}}
          @ariaHidden={{true}}
          @plainIcon={{@plainIcon}}
        />
      {{/if}}
    </div>
  </template>
}
