import { warn } from '@ember/debug';
import Component from '@glimmer/component';

import { VARIANTS } from '../../helpers/variants.js';

/**
 * @typedef {object} PixBlockArgs
 * @property {'primary' | 'orga' | 'certif' | 'admin' | 'modulix'} [variant] - Application à laquelle le bloc appartient, qui détermine ses couleurs. Par défaut : `primary`.
 * @property {boolean} [condensed] - Réduit les espacements intérieurs.
 */

/**
 * @typedef {object} PixBlockSignature
 * @property {HTMLDivElement} Element
 * @property {PixBlockArgs} Args
 * @property {{ default: [] }} Blocks
 */

export default class PixBlockComponent extends Component {
  get variant() {
    const value = this.args.variant ?? 'primary';

    warn(
      `PixBlock: @variant "${value}" should be ${VARIANTS.join(', ')}`,
      VARIANTS.includes(value),
      {
        id: 'pix-ui.pix-block.variant.not-valid',
      },
    );

    return value;
  }

  get cssClass() {
    const cssClass = ['pix-block', `pix-block--variant-${this.variant}`];

    if (this.args.condensed) {
      cssClass.push('pix-block--condensed');
    }

    return cssClass.join(' ');
  }

  <template>
    <div class={{this.cssClass}} ...attributes>

      {{yield}}

    </div>
  </template>
}
