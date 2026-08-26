import { action } from '@ember/object';
import { guidFor } from '@ember/object/internals';
import { service } from '@ember/service';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import PixLabel from './pix-label.gjs';
import PixMultiSelect from './pix-multi-select.gjs';
import PixSelect from './pix-select.gjs';

/**
 * @typedef {object} PixFilterableAndSearchableSelectOption
 * @property {string} value - Valeur de l'option.
 * @property {string} label - Texte affiché.
 * @property {string} category - Catégorie de l'option. Alimente la liste des filtres.
 */

/**
 * @typedef {object} PixFilterableAndSearchableSelectArgs
 * @property {PixFilterableAndSearchableSelectOption[]} options - Options proposées, chacune rattachée à une catégorie. Obligatoire.
 * @property {(value: string) => unknown} onChange - Appelée avec la valeur de l'option choisie. Obligatoire.
 * @property {string} [value] - Valeur de l'option sélectionnée.
 * @property {string} [placeholder] - Texte affiché tant qu'aucune option n'est sélectionnée.
 * @property {string} [categoriesPlaceholder] - Texte du filtre par catégories, suivi du nombre de catégories cochées.
 * @property {boolean} [isSearchable] - Ajoute un champ de recherche à la liste des options.
 * @property {boolean} [hideDefaultOption] - Retire l'option qui permet de revenir à « aucun choix ».
 * @property {'small' | 'default' | 'large'} [size] - Taille du libellé. Par défaut : `default`.
 * @property {string} [requiredLabel] - Rend le champ obligatoire et affiche un astérisque, dont ce texte est l'infobulle.
 * @property {string} [subLabel] - Complément d'information affiché sous le libellé.
 * @property {boolean} [screenReaderOnly] - Masque le libellé visuellement, tout en le laissant lisible par les lecteurs d'écran.
 * @property {boolean} [inlineLabel] - Place le libellé sur la même ligne que le champ.
 * @property {string} [errorMessage] - Message d'erreur affiché sous le champ. Sa présence applique le style d'erreur.
 */

/**
 * @typedef {object} PixFilterableAndSearchableSelectSignature
 * @property {HTMLDivElement} Element
 * @property {PixFilterableAndSearchableSelectArgs} Args
 * @property {{ label: [], categoriesLabel: [] }} Blocks
 */

export default class PixFilterableAndSearchableSelect extends Component {
  @service elementHelper;
  @tracked selectedCategories = [];

  constructor(...args) {
    super(...args);
    this.mainId = 'pix-pfass-' + guidFor(this);
    this.pixSelectId = 'pix-pfass-select-' + guidFor(this);
    this.pixMultiSelectId = 'pix-pfass-multi-select-' + guidFor(this);

    this.elementHelper.waitForElement(this.pixSelectId).then(() => {
      const baseFontRemRatio = Number(
        getComputedStyle(document.querySelector('html')).fontSize.match(/\d+(\.\d+)?/)[0],
      );

      const multiSelectWidth = document
        .getElementById(this.pixMultiSelectId)
        .getBoundingClientRect().width;

      const selectWidth = Math.ceil(multiSelectWidth / baseFontRemRatio);

      const className = `sizing-select-${this.pixSelectId}`;
      this.elementHelper.createClass(`.${className}`, `width: calc(100% - ${selectWidth}rem);`);

      const element = document.getElementById(`container-${this.pixSelectId}`);

      element.className = element.className + ' ' + className;
    });
  }

  @action
  selectCategories(categories) {
    this.selectedCategories = categories;
  }

  get categories() {
    const categoryNames = [];
    this.args.options.forEach((option) => {
      if (!categoryNames.includes(option.category)) {
        categoryNames.push(option.category);
      }
    });

    return categoryNames.map((category) => {
      return { label: category, value: category };
    });
  }

  get categoriesPlaceholder() {
    return `${this.args.categoriesPlaceholder} (${this.selectedCategories.length})`;
  }

  get selectableOptions() {
    const selectableOptions = [];
    const categories =
      this.selectedCategories.length === 0
        ? this.categories.map(({ value }) => value)
        : this.selectedCategories;

    this.args.options.forEach((option) => {
      if (categories.includes(option.category)) {
        selectableOptions.push(option);
      }
    });

    return selectableOptions;
  }

  <template>
    <div id={{this.mainId}} ...attributes>
      <PixLabel
        @for={{this.pixSelectId}}
        @requiredLabel={{@requiredLabel}}
        @size={{@size}}
        @subLabel={{@subLabel}}
        @screenReaderOnly={{@screenReaderOnly}}
        @inlineLabel={{@inlineLabel}}
      >
        {{yield to="label"}}
      </PixLabel>
      <div
        class="pix-filterable-and-searchable-select{{if
            @errorMessage
            ' pix-filterable-and-searchable-select--error'
          }}"
      >
        <PixMultiSelect
          id={{this.pixMultiSelectId}}
          @values={{this.selectedCategories}}
          @options={{this.categories}}
          @onChange={{this.selectCategories}}
          @isComputeWidthDisabled={{true}}
          @screenReaderOnly={{true}}
          @className="pix-filterable-and-searchable-select__pix-multi-select"
        >
          <:label>{{yield to="categoriesLabel"}}</:label>
          <:placeholder>{{this.categoriesPlaceholder}}</:placeholder>
          <:default as |option|>{{option.label}}</:default>
        </PixMultiSelect>
        <PixSelect
          @id={{this.pixSelectId}}
          @placeholder={{@placeholder}}
          @value={{@value}}
          @options={{this.selectableOptions}}
          @onChange={{@onChange}}
          @isSearchable={{@isSearchable}}
          @searchLabel={{@searchLabel}}
          @screenReaderOnly={{true}}
          @hideDefaultOption={{@hideDefaultOption}}
          @className="pix-filterable-and-searchable-select__pix-select"
          @isComputeWidthDisabled={{true}}
        />
      </div>
      {{#if @errorMessage}}
        <p class="pix-filterable-and-searchable-select__error-message">{{@errorMessage}}</p>
      {{/if}}
    </div>
  </template>
}
