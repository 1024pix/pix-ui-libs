import { on } from '@ember/modifier';
import { action } from '@ember/object';
import Component from '@glimmer/component';

import PixButton from '../actions/pix-button.gjs';
import PixIcon from '../graphics/pix-icon.gjs';

/**
 * @typedef {object} PixFilterBannerArgs
 * @property {string} [title] - Titre du bandeau, précédé d'une icône de filtre.
 * @property {string} [details] - Précision affichée à côté des actions, le nombre de résultats par exemple.
 * @property {string} [clearFiltersLabel] - Libellé du bouton de réinitialisation. Sa présence affiche le bouton.
 * @property {(event: MouseEvent) => unknown} [onClearFilters] - Appelée au clic sur ce bouton.
 * @property {boolean} [isClearFilterButtonDisabled] - Désactive ce bouton, quand aucun filtre n'est actif par exemple.
 * @property {string} [loadFiltersLabel] - Libellé du bouton de validation. Sa présence affiche le bouton.
 * @property {(event: SubmitEvent) => unknown} [onLoadFilters] - Appelée à la validation du formulaire.
 */

/**
 * @typedef {object} PixFilterBannerSignature
 * @property {HTMLFormElement} Element
 * @property {PixFilterBannerArgs} Args
 * @property {{ default: [] }} Blocks
 */

export default class PixFilterBanner extends Component {
  get displayTitle() {
    return Boolean(this.args.title);
  }

  get displayDetails() {
    return Boolean(this.args.details);
  }

  get displayClearFilters() {
    return Boolean(this.args.clearFiltersLabel);
  }

  get displayLoadFilters() {
    return Boolean(this.args.loadFiltersLabel);
  }

  get displayActionMenu() {
    return this.displayClearFilters || this.displayDetails || this.displayLoadFilters;
  }

  @action
  onSubmit(event) {
    event.preventDefault();
    if (this.args.onLoadFilters) {
      this.args.onLoadFilters(event);
    }
  }

  <template>
    <form {{on "submit" this.onSubmit}} class="pix-filter-banner" ...attributes>
      {{#if this.displayTitle}}
        <p class="pix-filter-banner__title">
          <PixIcon
            @name="filter"
            @plainIcon={{true}}
            class="pix-filter-banner__icon-title"
            aria-hidden="true"
          />
          {{@title}}
        </p>
      {{/if}}

      <div class="pix-filter-banner__container">
        <div class="pix-filter-banner__filter">
          {{yield}}
        </div>

        {{#if this.displayActionMenu}}
          <div class="pix-filter-banner__action">
            {{#if this.displayDetails}}
              <p>{{@details}}</p>
            {{/if}}

            {{#if this.displayLoadFilters}}
              <PixButton @variant="primary" @type="submit" @size="small">
                {{@loadFiltersLabel}}
              </PixButton>
            {{/if}}

            {{#if this.displayClearFilters}}
              <PixButton
                class="pix-filter-banner__button"
                @iconBefore="delete"
                @variant="tertiary"
                @size="small"
                @triggerAction={{@onClearFilters}}
                @isDisabled={{@isClearFilterButtonDisabled}}
              >
                {{@clearFiltersLabel}}
              </PixButton>
            {{/if}}
          </div>
        {{/if}}
      </div>
    </form>
  </template>
}
