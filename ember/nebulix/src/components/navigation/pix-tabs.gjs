import { warn } from '@ember/debug';
import Component from '@glimmer/component';

/**
 * @typedef {object} PixTabsArgs
 * @property {string} ariaLabel - Nom du groupe d'onglets, lu par les lecteurs d'écran. Obligatoire : il distingue cette navigation des autres de la page.
 * @property {'primary' | 'orga' | 'certif'} [variant] - Application à laquelle les onglets appartiennent, qui détermine leurs couleurs. Par défaut : `primary`.
 */

/**
 * @typedef {object} PixTabsSignature
 * @property {HTMLElement} Element
 * @property {PixTabsArgs} Args
 * @property {{ default: [] }} Blocks
 */

export default class PixTabs extends Component {
  get variant() {
    const value = this.args.variant ?? 'primary';
    warn(
      `PixTabs: @variant "${value}" should be certif, orga or primary`,
      ['primary', 'orga', 'certif'].includes(value),
      {
        id: 'pix-ui.pix-tabs.variant.not-valid',
      },
    );

    return value;
  }

  get ariaLabel() {
    const value = this.args.ariaLabel;
    warn('PixTabs: @ariaLabel is required.', !['', null, undefined].includes(value), {
      id: 'pix-ui.pix-tabs.ariaLabel.required',
    });

    return value;
  }

  get classNames() {
    return ['pix-tabs', `pix-tabs--${this.variant}`].join(' ');
  }

  <template>
    <nav class={{this.classNames}} aria-label={{this.ariaLabel}} ...attributes>
      {{yield}}
    </nav>
  </template>
}
