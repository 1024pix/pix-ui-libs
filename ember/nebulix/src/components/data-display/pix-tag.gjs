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
 * @property {'neutral' | 'neutral-light' | 'secondary' | 'tertiary' | 'success' | 'success-light' | 'error' | 'error-light' | 'orga' | 'blue' | 'blue-light' | 'green' | 'green-light' | 'yellow' | 'yellow-light' | 'orange' | 'orange-light' | 'purple' | 'purple-light' | 'grey' | 'grey-light' | 'dark' | 'white'} [color] - Deprécié, utiliser variant à la place Couleur de l'étiquette.
 * @property {'neutral' | 'neutral-light' | 'secondary' | 'tertiary' | 'success' | 'success-light' | 'error' | 'error-light' | 'orga' | 'blue' | 'blue-light' | 'green' | 'green-light' | 'yellow' | 'yellow-light' | 'orange' | 'orange-light' | 'purple' | 'purple-light' | 'grey' | 'grey-light' | 'dark' | 'white'} [variant] - Couleur de l'étiquette.
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

    if (this.args.color) {
      warn('PixTag: @color is deprecated use @variant instead', false, {
        id: 'pix-ui.pix-tag.color.deprecated',
      });
    }

    if (this.args.color || this.args.variant) {
      warn(
        `PixTag: ${this.args.color ?? this.args.variant} is deprecated refers to Design System to handle correct value`,
        (this.args.color &&
          ![
            'grey',
            'grey-light',
            'yellow-light',
            'yellow',
            'blue0',
            'green-light',
            'green',
            'orange',
            'orange-light',
            'orga',
            'purple',
            'purple-light',
          ].includes(this.args.color)) ||
          (this.args.variant &&
            ![
              'grey',
              'grey-light',
              'yellow-light',
              'yellow',
              'blue0',
              'green-light',
              'green',
              'orange',
              'orange-light',
              'orga',
              'purple',
              'purple-light',
            ].includes(this.args.variant)),
        {
          id: 'pix-ui.pix-tag.deprecated-color',
        },
      );
    }
  }

  get classes() {
    const { color, variant, type, textTransform, size } = this.args;
    const classes = [];
    if (size) classes.push(`pix-tag--${size}`);
    if (color || variant) classes.push(`pix-tag--${variant ?? color}`);
    if (type) classes.push(`pix-tag--${type}`);
    if (textTransform) classes.push(`pix-tag--${textTransform}`);
    return classes.join(' ');
  }

  <template>
    {{#if @onRemove}}
      <div class="pix-tag {{this.classes}}" ...attributes>
        <TagContent
          @iconBefore={{@iconBefore}}
          @iconAfter={{@iconAfter}}
          @plainIcon={{@plainIcon}}
        >{{yield}}
          <PixIconButton
            @ariaLabel={{@texts.removeButtonLabel}}
            @iconName="close"
            @size="xsmall"
            @triggerAction={{@onRemove}}
          />
        </TagContent>
      </div>
    {{else}}
      <span class="pix-tag {{this.classes}}" ...attributes>
        <TagContent
          @iconBefore={{@iconBefore}}
          @iconAfter={{@iconAfter}}
          @plainIcon={{@plainIcon}}
        >{{yield}}
        </TagContent>
      </span>
    {{/if}}
  </template>
}

const TagContent = <template>
  {{#if @iconBefore}}
    <PixIcon
      class="pix-tag__icon"
      @name={{@iconBefore}}
      @ariaHidden={{true}}
      @plainIcon={{@plainIcon}}
    />
  {{/if}}
  {{yield}}
  {{#if @iconAfter}}
    <PixIcon
      class="pix-tag__icon"
      @name={{@iconAfter}}
      @ariaHidden={{true}}
      @plainIcon={{@plainIcon}}
    />
  {{/if}}
</template>;
