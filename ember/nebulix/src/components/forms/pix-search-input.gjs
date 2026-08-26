import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { debounceTask } from 'ember-lifeline';

import PixIcon from '../graphics/pix-icon.gjs';
import PixInputBase from './pix-input-base.gjs';
import PixLabel from './pix-label.gjs';

/**
 * @typedef {object} PixSearchInputArgs
 * @property {(id: string, value: string) => unknown} triggerFiltering - Appelée avec l'identifiant du champ et le texte saisi, une fois le délai écoulé. Obligatoire.
 * @property {number | string} debounceTimeInMs - Délai d'attente en millisecondes après la dernière frappe avant d'appeler `triggerFiltering`. Obligatoire.
 * @property {string} [id] - Identifiant du champ. Généré automatiquement s'il n'est pas fourni.
 * @property {string} [value] - Valeur initiale du champ. Les modifications ultérieures de cet argument ne sont pas répercutées.
 * @property {string} [inputName] - Attribut `name` du champ.
 * @property {string} [placeholder] - Texte d'aide affiché dans le champ vide.
 * @property {'small' | 'default' | 'large'} [size] - Taille du libellé. Par défaut : `default`.
 * @property {string} [requiredLabel] - Rend le champ obligatoire et affiche un astérisque, dont ce texte est l'infobulle.
 * @property {string} [subLabel] - Complément d'information affiché sous le libellé.
 * @property {boolean} [screenReaderOnly] - Masque le libellé visuellement, tout en le laissant lisible par les lecteurs d'écran.
 * @property {boolean} [inlineLabel] - Place le libellé sur la même ligne que le champ.
 */

/**
 * @typedef {object} PixSearchInputSignature
 * @property {HTMLInputElement} Element
 * @property {PixSearchInputArgs} Args
 * @property {{ label: [] }} Blocks
 */

export default class PixSearchInput extends PixInputBase {
  initialValue = this.args.value;

  constructor() {
    super(...arguments);

    this.prefix = 'pix-search-input';

    this.debounceTimeBeforeSearch = parseInt(this.args.debounceTimeInMs);
    if (Number.isNaN(this.debounceTimeBeforeSearch)) {
      throw new Error('ERROR in PixSearchInput component, @debounceTimeInMs param is not provided');
    }
    if (!this.args.triggerFiltering) {
      throw new Error('ERROR in PixSearchInput component, @triggerFiltering param is not provided');
    }
  }

  debouncedTriggerFiltering(value) {
    this.args.triggerFiltering(this.id, value);
  }

  @action
  onSearch(event) {
    debounceTask(
      this,
      'debouncedTriggerFiltering',
      event.target.value,
      this.debounceTimeBeforeSearch,
    );
  }

  <template>
    <div class="pix-search-input {{if @inlineLabel ' pix-search-input--inline'}}">
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

      <div class="pix-search-input__input-container">
        <PixIcon @name="search" @ariaHidden={{true}} />
        <input
          id={{this.id}}
          class="pix-search-input__input"
          name={{@inputName}}
          placeholder={{@placeholder}}
          value={{this.initialValue}}
          {{on "input" this.onSearch}}
          ...attributes
        />
      </div>
    </div>
  </template>
}
