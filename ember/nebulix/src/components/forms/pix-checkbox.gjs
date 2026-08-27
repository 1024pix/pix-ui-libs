import { warn } from '@ember/debug';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { guidFor } from '@ember/object/internals';
import Component from '@glimmer/component';

import { formatMessage } from '../../translations/index.js';
import PixLabelWrapped from './pix-label-wrapped.gjs';

/**
 * @typedef {object} PixCheckboxArgs
 * @property {string} [id] - Identifiant de la case. Généré automatiquement s'il n'est pas fourni.
 * @property {boolean} [checked] - Coche la case.
 * @property {boolean} [isIndeterminate] - Affiche la case dans un état intermédiaire, ni cochée ni décochée.
 * @property {boolean} [isDisabled] - Désactive la case.
 * @property {'success' | 'error' | 'neutral' | 'declarative' | 'declarative-selected'} [state] - État de correction affiché après validation. Annoncé aux lecteurs d'écran. Les valeurs `neutral`, `declarative` et `declarative-selected` ne sont disponibles qu'avec `variant="modulix"`.
 * @property {'modulix'} [variant] - Jeu de styles alternatif.
 * @property {'small' | 'default' | 'large'} [size] - Taille du libellé. Par défaut : `default`.
 * @property {string} [requiredLabel] - Rend la case obligatoire et affiche un astérisque, dont ce texte est l'infobulle.
 * @property {string} [subLabel] - Complément d'information affiché sous le libellé.
 * @property {boolean} [screenReaderOnly] - Masque le libellé visuellement, tout en le laissant lisible par les lecteurs d'écran.
 * @property {'fr' | 'en' | 'es' | 'es-419' | 'nl'} [locale] - Langue des messages d'état annoncés aux lecteurs d'écran. Par défaut : `fr`.
 * @property {string} [class] - Classes CSS ajoutées au conteneur.
 */

/**
 * @typedef {object} PixCheckboxSignature
 * @property {HTMLInputElement} Element
 * @property {PixCheckboxArgs} Args
 * @property {{ label: [] }} Blocks
 */

export default class PixCheckbox extends Component {
  constructor() {
    super(...arguments);
  }

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

  get hasDeclarativeState() {
    return this.args.state === 'declarative' || this.args.state === 'declarative-selected';
  }

  get inputClasses() {
    const classes = ['pix-checkbox__input'];

    if (this.args.isIndeterminate) {
      classes.push(`${classes[0]}--indeterminate`);
    }

    if (this.hasSuccessState || this.hasErrorState) {
      classes.push(`${classes[0]}--state`);
    }

    return classes.join(' ');
  }

  get isDisabled() {
    warn(
      'PixCheckbox: @isDisabled attribute should be a boolean.',
      [true, false, undefined, null].includes(this.args.isDisabled),
      {
        id: 'pix-ui.checkbox.is-disabled.not-boolean',
      },
    );

    return this.args.isDisabled || this.args.disabled ? 'true' : null;
  }

  @action
  avoidCheckedStateChangeIfIsDisabled(event) {
    if (this.args.isDisabled) {
      event.preventDefault();
    }
  }

  get stateSuccessMessage() {
    return this.formatMessage('state.success');
  }

  get stateErrorMessage() {
    return this.formatMessage('state.error');
  }

  get stateDeclarativeMessage() {
    return this.formatMessage('state.declarative');
  }

  formatMessage(message) {
    return formatMessage(this.args.locale ?? 'fr', `input.${message}`);
  }

  <template>
    <div class="pix-checkbox {{@class}}">
      <PixLabelWrapped
        @for={{this.id}}
        @requiredLabel={{@requiredLabel}}
        @subLabel={{@subLabel}}
        @size={{@size}}
        @inlineLabel={{true}}
        @screenReaderOnly={{@screenReaderOnly}}
        @isDisabled={{this.isDisabled}}
        @variant={{@variant}}
        @state={{@state}}
      >
        <:inputElement>
          <input
            type="checkbox"
            id={{this.id}}
            class={{this.inputClasses}}
            checked={{@checked}}
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
        {{else if this.hasDeclarativeState}}
          {{this.stateDeclarativeMessage}}
        {{/if}}
      </span>
    </div>
  </template>
}
