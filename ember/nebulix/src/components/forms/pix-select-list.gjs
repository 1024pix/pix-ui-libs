import { concat, fn } from '@ember/helper';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { eq } from 'ember-truth-helpers';

import onEnterAction from '../../modifiers/on-enter-action.js';
import onSpaceAction from '../../modifiers/on-space-action.js';
import PixIcon from '../graphics/pix-icon.gjs';

/**
 * @typedef {object} PixSelectListOption
 * @property {string} value - Valeur de l'option.
 * @property {string} label - Texte affiché.
 * @property {string} [category] - Regroupe l'option sous une catégorie.
 * @property {string} [icon] - Nom d'une icône affichée avant le texte.
 * @property {string} [iconTitle] - Description de l'icône pour les lecteurs d'écran.
 */

/**
 * @typedef {object} PixSelectListArgs
 * @property {PixSelectListOption[]} options - Options à afficher.
 * @property {string} listId - Identifiant de la liste.
 * @property {string} selectId - Identifiant du champ qui ouvre la liste.
 * @property {string} [value] - Valeur de l'option sélectionnée.
 * @property {(option: PixSelectListOption, event: Event) => unknown} onChange - Appelée avec l'option choisie.
 * @property {boolean} [isExpanded] - Indique que la liste est ouverte, et donc navigable au clavier.
 * @property {boolean} [displayDefaultOption] - Affiche l'option par défaut en tête de liste.
 * @property {boolean} [hideDefaultOption] - Rend l'option par défaut inatteignable au clavier.
 * @property {PixSelectListOption} [defaultOption] - Option par défaut, celle qui correspond à « aucun choix ».
 * @property {string} [defaultOptionValue] - Texte de l'option par défaut.
 * @property {string} [searchValue] - Texte de recherche filtrant les options affichées.
 * @property {string} [emptySearchMessage] - Message affiché quand aucune option ne correspond à la recherche.
 */

/**
 * @typedef {object} PixSelectListSignature
 * @property {HTMLUListElement} Element
 * @property {PixSelectListArgs} Args
 * @property {{}} Blocks
 */

export default class PixSelectList extends Component {
  get categories() {
    const uniqueCategories = new Set(
      ...this.args.options.map((option) => option.category).filter(Boolean),
    );
    return Array.from(uniqueCategories.values());
  }

  get displayCategory() {
    return this.categories.length > 0;
  }

  get isDefaultOptionHidden() {
    return !this.args.isExpanded || this.args.hideDefaultOption;
  }

  get results() {
    const results = [];
    let options = this.args.options;

    if (this.args.searchValue) {
      options = this.args.options.filter((option) =>
        option.label.toLowerCase().includes(this.args.searchValue.toLowerCase()),
      );
    }

    if (!this.displayCategory) return options;

    options.forEach(({ category, value, label, icon, iconTitle }) => {
      const categoryIndex = results.findIndex((result) => result.category === category);
      if (categoryIndex !== -1) {
        results[categoryIndex].options.push({ value, label, icon, iconTitle });
      } else {
        results.push({ category, options: [{ label, value, icon, iconTitle }] });
      }
    });
    return results;
  }

  <template>
    <ul role="listbox" id={{@listId}} class="pix-select_list" ...attributes>
      {{#if @displayDefaultOption}}
        <li
          class="pix-select-list-category__option{{unless
              @value
              ' pix-select-list-category__option--selected'
            }}"
          role="option"
          tabindex={{if this.isDefaultOptionHidden "-1" "0"}}
          aria-selected={{if @value "false" "true"}}
          {{on "click" (fn @onChange @defaultOption)}}
          {{onEnterAction (fn @onChange @defaultOption)}}
          {{onSpaceAction (fn @onChange @defaultOption)}}
        >
          {{@defaultOptionValue}}
        </li>
      {{/if}}
      {{#if this.results}}
        {{#if this.displayCategory}}
          {{#each this.results as |element index|}}
            <ul
              class="pix-select-list-category"
              role="group"
              aria-labelledby={{if this.displayCategory (concat "cat-" @selectId "-" index)}}
            >
              {{#if this.displayCategory}}
                <li
                  class="pix-select-list-category__name"
                  role="presentation"
                  id={{concat "cat-" @selectId "-" index}}
                  title={{element.label}}
                >
                  {{element.category}}
                </li>
              {{/if}}

              {{#each element.options as |option|}}
                {{! template-lint-disable require-context-role }}
                {{!https://www.w3.org/WAI/ARIA/apg/example-index/listbox/listbox-grouped.html}}
                <li
                  class="pix-select-list-category__option{{if
                      (eq option.value @value)
                      ' pix-select-list-category__option--selected'
                    }}"
                  role="option"
                  tabindex={{if @isExpanded "0" "-1"}}
                  title={{option.label}}
                  aria-selected={{if (eq option.value @value) "true" "false"}}
                  {{on "click" (fn @onChange option)}}
                  {{onEnterAction (fn @onChange option)}}
                  {{onSpaceAction (fn @onChange option)}}
                >

                  {{#if option.icon}}
                    <PixIcon
                      role="presentation"
                      @name={{option.icon}}
                      @title={{option.iconTitle}}
                      class="pix-icon--no-shrink"
                    />
                  {{/if}}

                  {{option.label}}

                  {{#if (eq option.value @value)}}
                    <PixIcon
                      @name="check"
                      role="presentation"
                      class="pix-select-list-category__option-checked"
                    />
                  {{/if}}
                </li>
              {{/each}}
            </ul>
          {{/each}}
        {{else}}
          {{#each this.results as |option|}}
            <li
              class="pix-select-list-category__option{{if
                  (eq option.value @value)
                  ' pix-select-list-category__option--selected'
                }}"
              role="option"
              tabindex={{if @isExpanded "0" "-1"}}
              aria-selected={{if (eq option.value @value) "true" "false"}}
              title={{option.label}}
              {{on "click" (fn @onChange option)}}
              {{onEnterAction (fn @onChange option)}}
              {{onSpaceAction (fn @onChange option)}}
            >
              {{#if option.icon}}
                <PixIcon
                  role="presentation"
                  @name={{option.icon}}
                  @title={{option.iconTitle}}
                  class="pix-icon--no-shrink"
                />
              {{/if}}

              {{option.label}}

              {{#if (eq option.value @value)}}
                <PixIcon
                  @name="check"
                  role="presentation"
                  class="pix-select-list-category__option-checked"
                />
              {{/if}}
            </li>
          {{/each}}
        {{/if}}
      {{else}}
        <li class="pix-select-list__empty-search-message">{{@emptySearchMessage}}</li>
      {{/if}}
    </ul>
  </template>
}
