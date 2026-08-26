import PixIcon from '../graphics/pix-icon.gjs';
import PixInputBase from './pix-input-base.gjs';
import PixLabel from './pix-label.gjs';

/**
 * @typedef {object} PixInputArgs
 * @property {string} [id] - Identifiant du champ. Généré automatiquement s'il n'est pas fourni.
 * @property {string} [value] - Valeur du champ.
 * @property {'small' | 'default' | 'large'} [size] - Taille du libellé. Par défaut : `default`.
 * @property {string} [requiredLabel] - Rend le champ obligatoire et affiche un astérisque, dont ce texte est l'infobulle.
 * @property {string} [subLabel] - Complément d'information affiché sous le libellé.
 * @property {boolean} [screenReaderOnly] - Masque le libellé visuellement, tout en le laissant lisible par les lecteurs d'écran.
 * @property {boolean} [inlineLabel] - Place le libellé sur la même ligne que le champ.
 * @property {boolean} [isFullWidth] - Étend le champ à toute la largeur disponible.
 * @property {'default' | 'error' | 'success'} [validationStatus] - État de validation du champ. Par défaut : `default`.
 * @property {string} [errorMessage] - Message affiché sous le champ lorsque `validationStatus` vaut `error`.
 */

/**
 * @typedef {object} PixInputSignature
 * @property {HTMLInputElement} Element
 * @property {PixInputArgs} Args
 * @property {{ label: [] }} Blocks
 */

export default class PixInput extends PixInputBase {
  constructor() {
    super(...arguments);

    this.prefix = 'pix-input';
    this.inputValidationError = {
      default: '',
      error: 'pix-input__input--error',
      success: 'pix-input__input--success',
    };
  }

  <template>
    <div class={{this.rootClassNames}}>
      {{#if (has-block "label")}}
        <PixLabel
          @for={{this.id}}
          @requiredLabel={{@requiredLabel}}
          @subLabel={{@subLabel}}
          @size={{@size}}
          @screenReaderOnly={{@screenReaderOnly}}
          @inlineLabel={{@inlineLabel}}
        >
          {{yield to="label"}}
        </PixLabel>
      {{/if}}
      <div class="pix-input__field-container">
        <div class="pix-input__container">
          <input
            id={{this.id}}
            class="pix-input__input {{this.validationStatusClassName}}"
            value={{@value}}
            aria-required="{{if @requiredLabel true false}}"
            required={{if @requiredLabel true false}}
            aria-describedby={{this.ariaDescribedBy}}
            ...attributes
          />

          {{#if this.hasError}}
            <PixIcon @name="close" class="pix-input__error-icon" @ariaHidden={{true}} />
          {{/if}}
          {{#if this.hasSuccess}}
            <PixIcon @name="check" class="pix-input__success-icon" @ariaHidden={{true}} />
          {{/if}}
        </div>

        {{#if this.hasErrorMessage}}
          <p id={{this.ariaDescribedBy}} class="pix-input__error-message">{{@errorMessage}}</p>
        {{/if}}
      </div>
    </div>
  </template>
}
