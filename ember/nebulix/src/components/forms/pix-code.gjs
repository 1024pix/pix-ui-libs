import { warn } from '@ember/debug';
import { htmlSafe } from '@ember/template';

import PixInputBase from './pix-input-base.gjs';
import PixLabel from './pix-label.gjs';

/**
 * @typedef {object} PixCodeArgs
 * @property {number} length - Nombre de caractères attendus. Obligatoire : il fixe à la fois la largeur du champ et les longueurs minimale et maximale acceptées.
 * @property {string} [id] - Identifiant du champ. Généré automatiquement s'il n'est pas fourni.
 * @property {string} [value] - Valeur du champ.
 * @property {'small' | 'default' | 'large'} [size] - Taille du libellé. Par défaut : `default`.
 * @property {string} [requiredLabel] - Rend le champ obligatoire et affiche un astérisque, dont ce texte est l'infobulle.
 * @property {string} [subLabel] - Complément d'information affiché sous le libellé.
 * @property {boolean} [screenReaderOnly] - Masque le libellé visuellement, tout en le laissant lisible par les lecteurs d'écran.
 * @property {'default' | 'error' | 'success'} [validationStatus] - État de validation du champ. Par défaut : `default`.
 * @property {string} [errorMessage] - Message affiché sous le champ lorsque `validationStatus` vaut `error`.
 */

/**
 * @typedef {object} PixCodeSignature
 * @property {HTMLInputElement} Element
 * @property {PixCodeArgs} Args
 * @property {{ label: [] }} Blocks
 */

export default class PixCode extends PixInputBase {
  constructor() {
    super(...arguments);

    this.prefix = 'pix-code';
  }

  get length() {
    warn('PixCode: @length is required.', !['', null, undefined].includes(this.args.length), {
      id: 'pix-ui.code.length.required',
    });

    return this.args.length || 1;
  }

  get style() {
    return htmlSafe('--nb-characters:' + this.length);
  }

  <template>
    <div>
      {{#if (has-block "label")}}
        <PixLabel
          @for={{this.id}}
          @requiredLabel={{@requiredLabel}}
          @subLabel={{@subLabel}}
          @size={{@size}}
          @screenReaderOnly={{@screenReaderOnly}}
        >
          {{yield to="label"}}
        </PixLabel>
      {{/if}}
      <div>
        <input
          id={{this.id}}
          class="pix-code"
          style={{this.style}}
          value={{@value}}
          aria-required="{{if @requiredLabel true false}}"
          required={{if @requiredLabel true false}}
          maxlength={{this.length}}
          minlength={{this.length}}
          aria-describedby={{this.ariaDescribedBy}}
          ...attributes
        />

        {{#if this.hasErrorMessage}}
          <p id={{this.ariaDescribedBy}} class="pix-code__error-message">{{@errorMessage}}</p>
        {{/if}}
      </div>
    </div>
  </template>
}
