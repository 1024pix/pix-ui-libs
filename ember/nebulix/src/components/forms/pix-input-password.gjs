import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

import PixIconButton from '../actions/pix-icon-button.gjs';
import PixIcon from '../graphics/pix-icon.gjs';
import PixInputBase from './pix-input-base.gjs';
import PixLabel from './pix-label.gjs';

/**
 * @typedef {object} PixInputPasswordArgs
 * @property {string} [id] - Identifiant du champ. Généré automatiquement s'il n'est pas fourni.
 * @property {string} [value] - Valeur du champ.
 * @property {string} [prefix] - Texte affiché avant le champ, à l'intérieur de la bordure.
 * @property {'small' | 'default' | 'large'} [size] - Taille du libellé. Par défaut : `default`.
 * @property {string} [requiredLabel] - Rend le champ obligatoire et affiche un astérisque, dont ce texte est l'infobulle.
 * @property {string} [subLabel] - Complément d'information affiché sous le libellé.
 * @property {boolean} [screenReaderOnly] - Masque le libellé visuellement, tout en le laissant lisible par les lecteurs d'écran.
 * @property {boolean} [inlineLabel] - Place le libellé sur la même ligne que le champ.
 * @property {'default' | 'error' | 'success'} [validationStatus] - État de validation du champ. Par défaut : `default`.
 * @property {string} [errorMessage] - Message affiché sous le champ lorsque `validationStatus` vaut `error`.
 */

/**
 * @typedef {object} PixInputPasswordSignature
 * @property {HTMLInputElement} Element
 * @property {PixInputPasswordArgs} Args
 * @property {{ label: [] }} Blocks
 */

export default class PixInputPassword extends PixInputBase {
  constructor() {
    super(...arguments);

    this.prefix = 'pix-input-password';
    this.inputValidationError = {
      default: '',
      error: 'pix-input-password__container--error',
      success: 'pix-input-password__container--success',
    };
  }

  @tracked isPasswordVisible = false;

  @action
  togglePasswordVisibility() {
    this.isPasswordVisible = !this.isPasswordVisible;
    const InputElement = document.getElementById(this.args.id);
    if (InputElement) {
      InputElement.focus();
    }
  }

  <template>
    <div class="pix-input-password {{if @inlineLabel ' pix-input-password--inline'}}">
      <PixLabel
        @for={{this.id}}
        @requiredLabel={{@requiredLabel}}
        @size={{@size}}
        @subLabel={{@subLabel}}
        @screenReaderOnly={{@screenReaderOnly}}
        @inlineLabel={{@inlineLabel}}
      >
        {{yield to="label"}}
      </PixLabel>
      <div>
        <div
          class="pix-input-password__container
            {{this.validationStatusClassName}}
            {{if @prefix 'pix-input-password__with-prefix'}}"
        >

          {{#if @prefix}}
            <span class="pix-input-password__prefix">{{@prefix}}</span>
          {{/if}}

          <input
            id={{this.id}}
            type={{if this.isPasswordVisible "text" "password"}}
            value={{@value}}
            aria-required="{{if @requiredLabel true false}}"
            required={{if @requiredLabel true false}}
            aria-describedby={{this.ariaDescribedBy}}
            ...attributes
          />

          <PixIconButton
            class="pix-input-password__button"
            @iconName={{if this.isPasswordVisible "eye" "eyeOff"}}
            @plainIcon={{true}}
            @ariaLabel={{if
              this.isPasswordVisible
              "Masquer le mot de passe"
              "Afficher le mot de passe"
            }}
            @triggerAction={{this.togglePasswordVisibility}}
            @size="small"
          />

          {{#if this.hasError}}
            <PixIcon
              @name="close"
              @ariaHidden={{true}}
              class="pix-input-password__icon pix-input-password__error-icon"
            />
          {{/if}}
          {{#if this.hasSuccess}}
            <PixIcon
              @name="check"
              @ariaHidden={{true}}
              class="pix-input-password__icon pix-input-password__success-icon"
            />
          {{/if}}
        </div>

        {{#if this.hasErrorMessage}}
          <p id={{this.ariaDescribedBy}} class="pix-input-password__error-message">
            {{@errorMessage}}
          </p>
        {{/if}}
      </div>
    </div>
  </template>
}
