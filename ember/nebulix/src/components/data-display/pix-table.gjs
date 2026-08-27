import { warn } from '@ember/debug';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import Component from '@glimmer/component';

import { VARIANTS } from '../../helpers/variants.js';
import PixBlock from '../layout/pix-block.gjs';

/**
 * @typedef {object} PixTableArgs
 * @property {unknown[]} data - Lignes à afficher. Chaque élément est transmis au bloc `columns`.
 * @property {string} caption - Titre du tableau, qui en résume le contenu. Obligatoire : il est lu par les lecteurs d'écran avant le tableau.
 * @property {boolean} [displayCaption] - Affiche ce titre. Sinon, il n'est destiné qu'aux lecteurs d'écran.
 * @property {'primary' | 'orga' | 'certif' | 'admin' | 'modulix'} [variant] - Application à laquelle le tableau appartient, qui détermine les couleurs de son en-tête. Par défaut : `primary`.
 * @property {boolean} [condensed] - Réduit la hauteur des lignes.
 * @property {(row: unknown) => unknown} [onRowClick] - Appelée avec la ligne cliquée. Sa présence rend les lignes cliquables.
 */

/**
 * @typedef {object} PixTableSignature
 * @property {HTMLDivElement} Element
 * @property {PixTableArgs} Args
 * @property {{ columns: [unknown, 'header' | 'cell', number] }} Blocks
 */

export default class PixTable extends Component {
  get variant() {
    const value = this.args.variant ?? 'primary';
    warn(
      `PixTable: @variant "${value}" should be ${VARIANTS.join(', ')}`,
      VARIANTS.includes(value),
      {
        id: 'pix-ui.pix-table.variant.not-valid',
      },
    );

    return value;
  }

  get caption() {
    warn(`PixTable: @caption is required`, Boolean(this.args.caption), {
      id: 'pix-ui.pix-table.caption.required',
    });
    return this.args.caption;
  }

  get tableClass() {
    const tableClass = ['pix-table'];
    warn(
      'PixTable: @condensed must be a boolean, default undefined',
      [true, false, undefined].includes(this.args.condensed),
      {
        id: 'pix-ui.pix-table.condensed.not-boolean',
      },
    );
    if (this.args.condensed) {
      tableClass.push('pix-table--condensed');
    }

    return tableClass.join(' ');
  }

  get headerClass() {
    return `pix-table-header--${this.variant}`;
  }

  get captionClass() {
    return this.args.displayCaption ? 'pix-table__caption' : 'screen-reader-only';
  }

  get hasOnRowClick() {
    return typeof this.args.onRowClick === 'function';
  }

  @action
  onClick(row, event) {
    event.stopPropagation();
    if (this.hasOnRowClick) {
      this.args.onRowClick(row);
    }
  }

  <template>
    <PixBlock @variant={{@variant}} class={{this.tableClass}} ...attributes>
      <table>
        <caption class={{this.captionClass}}>{{this.caption}}</caption>
        <thead class={{this.headerClass}}>
          <tr>
            {{yield null "header" to="columns"}}
          </tr>
        </thead>
        <tbody>
          {{#each @data as |row index|}}
            <tr
              class={{if this.hasOnRowClick "pix-table__clickable-row" ""}}
              {{on "click" (fn this.onClick row)}}
            >
              {{yield row "cell" index to="columns"}}
            </tr>
          {{/each}}
        </tbody>
      </table>
    </PixBlock>
  </template>
}
