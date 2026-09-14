import { action } from '@ember/object';
import { service } from '@ember/service';
import Component from '@glimmer/component';

import PixIconButton from '../actions/pix-icon-button.gjs';
import PixSelect from '../forms/pix-select.gjs';

const DEFAULT_PAGE_OPTIONS = [
  { label: '10', value: 10 },
  { label: '25', value: 25 },
  { label: '50', value: 50 },
  { label: '100', value: 100 },
];

/**
 * @typedef {object} PixPaginationState
 * @property {number} page - Numéro de la page affichée, à partir de 1.
 * @property {number} pageSize - Nombre de résultats par page.
 * @property {number} pageCount - Nombre total de pages.
 * @property {number} rowCount - Nombre total de résultats.
 */

/**
 * @typedef {object} PixPaginationOption
 * @property {string} label - Texte affiché dans la liste des tailles de page.
 * @property {number} value - Nombre de résultats correspondant.
 */

/**
 * @typedef {object} PixPaginationTexts
 * @property {string} title - Libellé affiché avant le sélecteur de taille de page (ex. « Voir »).
 * @property {string} pageSize - Libellé accessible du sélecteur de taille de page.
 * @property {string} pageElementCount - Texte décrivant les éléments affichés (ex. « 11-12 sur 12 éléments »).
 * @property {string} previousPage - Libellé accessible du bouton page précédente.
 * @property {string} pageNumber - Texte affichant la page courante (ex. « Page 2 / 6 »).
 * @property {string} nextPage - Libellé accessible du bouton page suivante.
 */

/**
 * @typedef {object} PixPaginationArgs
 * @property {PixPaginationState} pagination - État courant de la pagination. Obligatoire.
 * @property {PixPaginationTexts} texts - Textes affichés par le composant. À fournir par l'application consommatrice, dans la langue de son choix. Obligatoire.
 * @property {PixPaginationOption[]} [pageOptions] - Tailles de page proposées. Par défaut : 10, 25, 50 et 100.
 * @property {() => unknown} [onChange] - Appelée après chaque changement de page ou de taille de page.
 * @property {boolean} [isCondensed] - Affiche la version compacte.
 */

/**
 * @typedef {object} PixPaginationSignature
 * @property {null} Element
 * @property {PixPaginationArgs} Args
 * @property {{}} Blocks
 */

export default class PixPagination extends Component {
  @service router;

  get isCondensed() {
    return this.args.isCondensed ? 'pix-pagination-condensed' : 'pix-pagination';
  }

  get pageOptions() {
    return this.args.pageOptions ? this.args.pageOptions : DEFAULT_PAGE_OPTIONS;
  }

  get currentPage() {
    return this.args.pagination ? this.args.pagination.page : 1;
  }

  get pageCount() {
    if (!this.args.pagination) return 0;
    if (this.args.pagination.pageCount === 0) return 1;
    return this.args.pagination.pageCount;
  }

  get pageSize() {
    return this.args.pagination ? this.args.pagination.pageSize : this.pageOptions[0].value;
  }

  get isNextPageDisabled() {
    return this.currentPage === this.pageCount || this.pageCount === 0;
  }

  get nextPage() {
    return Math.min(this.currentPage + 1, this.pageCount);
  }

  get isPreviousPageDisabled() {
    return this.currentPage === 1 || this.pageCount === 0;
  }

  get previousPage() {
    return Math.max(this.currentPage - 1, 1);
  }

  get firstItemPosition() {
    if (!this.args.pagination) return 0;
    return (this.currentPage - 1) * this.pageSize + 1;
  }

  get lastItemPosition() {
    if (!this.args.pagination) return 0;
    const { rowCount } = this.args.pagination;
    return Math.min(rowCount, this.firstItemPosition + this.pageSize - 1);
  }

  @action
  onChange() {
    if (typeof this.args.onChange !== 'function') return;

    this.args.onChange();
  }

  @action
  changePageSize(value) {
    this.router.replaceWith({ queryParams: { pageSize: value, pageNumber: 1 } });
    this.onChange();
  }

  @action
  goToNextPage() {
    this.router.replaceWith({ queryParams: { pageNumber: this.nextPage } });
    this.onChange();
  }

  @action
  goToPreviousPage() {
    this.router.replaceWith({ queryParams: { pageNumber: this.previousPage } });
    this.onChange();
  }

  <template>
    <footer class={{this.isCondensed}}>
      <section class="pix-pagination__size">
        <span class="pagination-size__label" aria-hidden="true">{{@texts.title}}</span>
        <PixSelect
          @placeholder={{this.pageSize}}
          @screenReaderOnly={{true}}
          class="pagination-size__choice"
          @value={{this.pageSize}}
          @hideDefaultOption={{true}}
          @onChange={{this.changePageSize}}
          @options={{this.pageOptions}}
        >
          <:label>{{@texts.pageSize}}</:label>
        </PixSelect>
      </section>
      <section class="pix-pagination__navigation">
        <span>
          {{@texts.pageElementCount}}
        </span>
        <div class="pix-pagination-navigation__action">
          <PixIconButton
            class="pix-pagination-navigation__action-button"
            @iconName="arrowLeft"
            @ariaLabel={{@texts.previousPage}}
            @triggerAction={{this.goToPreviousPage}}
            @withBackground={{false}}
            @size="big"
            @color="dark-grey"
            disabled={{this.isPreviousPageDisabled}}
            aria-disabled="{{this.isPreviousPageDisabled}}"
          />
          <span>
            {{@texts.pageNumber}}
          </span>
          <PixIconButton
            class="pix-pagination-navigation__action-button"
            @iconName="arrowRight"
            @ariaLabel={{@texts.nextPage}}
            @triggerAction={{this.goToNextPage}}
            @withBackground={{false}}
            @size="big"
            @color="dark-grey"
            disabled={{this.isNextPageDisabled}}
            aria-disabled="{{this.isNextPageDisabled}}"
          />
        </div>
      </section>
    </footer>
  </template>
}
