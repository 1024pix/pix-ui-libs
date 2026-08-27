import Component from '@glimmer/component';

import PixIcon from '../graphics/pix-icon.gjs';

/**
 * @typedef {object} PixLabelWrappedArgs
 * @property {string} [for] - Identifiant du champ décrit par ce libellé.
 * @property {'small' | 'default' | 'large'} [size] - Taille du texte. Par défaut : `default`.
 * @property {string} [requiredLabel] - Affiche un astérisque signalant un champ obligatoire, dont ce texte est l'infobulle.
 * @property {string} [subLabel] - Complément d'information affiché sous le libellé.
 * @property {boolean} [screenReaderOnly] - Masque le texte du libellé visuellement, tout en le laissant lisible par les lecteurs d'écran.
 * @property {boolean} [inlineLabel] - Place le libellé sur la même ligne que le champ.
 * @property {boolean} [isDisabled] - Applique le style désactivé au libellé.
 * @property {'modulix'} [variant] - Jeu de styles alternatif.
 * @property {'success' | 'error' | 'neutral' | 'declarative' | 'declarative-selected'} [state] - État de validation. `success` et `error` affichent une icône ; les autres valeurs ne sont disponibles qu'avec `variant="modulix"`.
 */

/**
 * @typedef {object} PixLabelWrappedSignature
 * @property {HTMLLabelElement} Element
 * @property {PixLabelWrappedArgs} Args
 * @property {{ default: [], inputElement: [] }} Blocks
 */

export default class PixLabelWrapped extends Component {
  get className() {
    const classes = ['pix-label', 'pix-label-wrapped'];

    if (this.args.inlineLabel) classes.push('pix-label--inline-label');
    if (this.args.isDisabled) classes.push('pix-label-wrapped--disabled');
    if (this.args.variant === 'modulix') {
      classes.push('pix-label-wrapped--variant-modulix');
      if (this.args.state === 'success') classes.push('pix-label-wrapped--state-modulix-success');
      if (this.args.state === 'error') classes.push('pix-label-wrapped--state-modulix-error');
      if (this.args.state === 'neutral') classes.push('pix-label-wrapped--state-modulix-neutral');
      if (this.args.state === 'declarative')
        classes.push('pix-label-wrapped--state-modulix-declarative');
      if (this.args.state === 'declarative-selected')
        classes.push('pix-label-wrapped--state-modulix-declarative-selected');
    } else {
      if (this.args.state === 'success') classes.push('pix-label-wrapped--state-success');
      if (this.args.state === 'error') classes.push('pix-label-wrapped--state-error');
    }

    const size = ['small', 'large'].includes(this.args.size) ? this.args.size : 'default';

    classes.push(`pix-label--${size}`);

    return classes.join(' ');
  }

  get hasError() {
    return this.args.state === 'error';
  }

  get hasSuccess() {
    return this.args.state === 'success';
  }

  <template>
    <label for={{@for}} class={{this.className}} ...attributes>
      {{#if this.hasError}}
        <PixIcon
          @name="cancel"
          @plainIcon={{true}}
          @ariaHidden={{true}}
          class="pix-label-wrapped__state-icon"
        />
      {{/if}}
      {{#if this.hasSuccess}}
        <PixIcon
          @name="checkCircle"
          @plainIcon={{true}}
          @ariaHidden={{true}}
          class="pix-label-wrapped__state-icon"
        />
      {{/if}}

      {{yield to="inputElement"}}

      <span class="{{if @screenReaderOnly 'screen-reader-only'}}">
        {{yield}}

        {{#if @requiredLabel}}
          <abbr title={{@requiredLabel}} class="mandatory-mark">*</abbr>
        {{/if}}

        {{#if @subLabel}}
          <span class="pix-label__sub-label">{{@subLabel}}</span>
        {{/if}}
      </span>
    </label>
  </template>
}
