import { warn } from '@ember/debug';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { guidFor } from '@ember/object/internals';
import Component from '@glimmer/component';

import { formatMessage } from '../../translations/index.js';
import PixLabelWrapped from './pix-label-wrapped.gjs';

/**
 * @typedef {object} PixRadioButtonArgs
 * @property {string} [id] - Identifiant du bouton. Généré automatiquement s'il n'est pas fourni.
 * @property {string} [value] - Valeur transmise au formulaire lorsque le bouton est sélectionné.
 * @property {boolean} [isDisabled] - Désactive le bouton.
 * @property {'success' | 'error'} [state] - État de correction affiché après validation. Annoncé aux lecteurs d'écran.
 * @property {'modulix'} [variant] - Jeu de styles alternatif.
 * @property {'small' | 'default' | 'large'} [size] - Taille du libellé. Par défaut : `default`.
 * @property {string} [requiredLabel] - Rend le bouton obligatoire et affiche un astérisque, dont ce texte est l'infobulle.
 * @property {string} [subLabel] - Complément d'information affiché sous le libellé.
 * @property {boolean} [screenReaderOnly] - Masque le libellé visuellement, tout en le laissant lisible par les lecteurs d'écran.
 * @property {string} [class] - Classes CSS ajoutées au conteneur.
 */

/**
 * @typedef {object} PixRadioButtonSignature
 * @property {HTMLInputElement} Element
 * @property {PixRadioButtonArgs} Args
 * @property {{ label: [] }} Blocks
 */

export default class PixRadioButton extends Component {
  text = 'pix-radio-button';

  get id() {
    return this.args.id || guidFor(this);
  }

  get stateId() {
    return `${this.id}-state`;
  }

  get hasSuccessState() {
    return this.args.state === 'success';
  }

  get hasErrorState() {
    return this.args.state === 'error';
  }

  get isDisabled() {
    warn(
      'PixRadioButton: @isDisabled attribute should be a boolean.',
      [true, false, undefined, null].includes(this.args.isDisabled),
      {
        id: 'pix-ui.radio-button.is-disabled.not-boolean',
      },
    );

    return this.args.isDisabled || this.args.disabled ? 'true' : null;
  }

  get inputClasses() {
    const classes = ['pix-radio-button__input'];

    if (this.hasSuccessState || this.hasErrorState) {
      classes.push(`${classes[0]}--state`);
    }

    if (this.args.variant === 'modulix') {
      classes.push('pix-radio-button__input--variant-modulix');
    }

    return classes.join(' ');
  }

  get stateSuccessMessage() {
    return this.formatMessage('state.success');
  }

  get stateErrorMessage() {
    return this.formatMessage('state.error');
  }

  formatMessage(message) {
    return formatMessage('fr', `input.${message}`);
  }

  @action
  avoidCheckedStateChangeIfIsDisabled(event) {
    if (this.args.isDisabled) {
      event.preventDefault();
    }
  }

  <template>
    <div class="pix-radio-button {{@class}}">
      <PixLabelWrapped
        @for={{this.id}}
        @requiredLabel={{@requiredLabel}}
        @subLabel={{@subLabel}}
        @size={{@size}}
        @screenReaderOnly={{@screenReaderOnly}}
        @isDisabled={{this.isDisabled}}
        @inlineLabel={{true}}
        @variant={{@variant}}
        @state={{@state}}
      >
        <:inputElement>
          <input
            type="radio"
            id={{this.id}}
            class={{this.inputClasses}}
            value={{@value}}
            aria-disabled={{this.isDisabled}}
            aria-describedby={{this.stateId}}
            {{on "click" this.avoidCheckedStateChangeIfIsDisabled}}
            ...attributes
          />
        </:inputElement>
        <:default>
          {{yield to="label"}}
        </:default>
      </PixLabelWrapped>

      <span class="screen-reader-only" id={{this.stateId}}>
        {{#if this.hasSuccessState}}
          {{this.stateSuccessMessage}}
        {{else if this.hasErrorState}}
          {{this.stateErrorMessage}}
        {{/if}}
      </span>
    </div>
  </template>
}
