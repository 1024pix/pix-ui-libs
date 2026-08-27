import Component from '@glimmer/component';

/**
 * @typedef {object} PixLabelArgs
 * @property {string} [for] - Identifiant du champ décrit par ce libellé.
 * @property {'small' | 'default' | 'large'} [size] - Taille du texte. Par défaut : `default`.
 * @property {string} [requiredLabel] - Affiche un astérisque signalant un champ obligatoire, dont ce texte est l'infobulle.
 * @property {string} [subLabel] - Complément d'information affiché sous le libellé.
 * @property {boolean} [screenReaderOnly] - Masque le libellé visuellement, tout en le laissant lisible par les lecteurs d'écran.
 * @property {boolean} [inlineLabel] - Place le libellé sur la même ligne que le champ.
 * @property {boolean} [isDisabled] - Applique le style désactivé au libellé.
 * @property {boolean} [useAsLegend] - Rend un `<legend>` au lieu d'un `<label>`, pour intituler un groupe de champs.
 */

/**
 * @typedef {object} PixLabelSignature
 * @property {HTMLLabelElement | HTMLLegendElement} Element
 * @property {PixLabelArgs} Args
 * @property {{ default: [] }} Blocks
 */

export default class PixLabel extends Component {
  get className() {
    const classes = ['pix-label'];

    if (this.args.screenReaderOnly) classes.push('screen-reader-only');
    if (this.args.inlineLabel) classes.push('pix-label--inline-label');
    if (this.args.isDisabled) classes.push('pix-label--disabled');

    const size = ['small', 'large'].includes(this.args.size) ? this.args.size : 'default';

    classes.push(`pix-label--${size}`);

    return classes.join(' ');
  }

  <template>
    {{#if @useAsLegend}}
      <legend class={{this.className}} ...attributes>
        <ChoreLabel @requiredLabel={{@requiredLabel}} @subLabel={{@subLabel}}>{{yield}}</ChoreLabel>
      </legend>
    {{else}}
      <label for={{@for}} class={{this.className}} ...attributes>
        <ChoreLabel @requiredLabel={{@requiredLabel}} @subLabel={{@subLabel}}>{{yield}}</ChoreLabel>
      </label>
    {{/if}}
  </template>
}

const ChoreLabel = <template>
  {{yield}}
  {{#if @requiredLabel}}
    <abbr title={{@requiredLabel}} class="mandatory-mark">*</abbr>
  {{/if}}

  {{#if @subLabel}}
    <span class="pix-label__sub-label">{{@subLabel}}</span>
  {{/if}}
</template>;
