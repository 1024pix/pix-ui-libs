import Component from '@glimmer/component';

/**
 * Arguments communs aux boutons qui héritent de `PixButtonBase`.
 *
 * @typedef {object} PixButtonBaseArgs
 * @property {'primary' | 'primary-white' | 'primary-bis' | 'secondary' | 'secondary-white' | 'tertiary' | 'tertiary-white' | 'success' | 'error' | 'transparent-dark'} [variant] - Rôle du bouton dans la page, qui détermine ses couleurs. Par défaut : `primary`.
 * @property {'small' | 'large'} [size] - Hauteur et espacements du bouton. Par défaut : `small`.
 * @property {boolean} [isBorderVisible] - Ajoute une bordure. N'a d'effet qu'avec la variante `transparent-dark`.
 */

export default class PixButtonBase extends Component {
  get variant() {
    return this.args.variant || 'primary';
  }

  get size() {
    return this.args.size || 'small';
  }

  get baseClassNames() {
    const classNames = [
      'pix-button',
      `pix-button--size-${this.size}`,
      `pix-button--${this.variant}`,
    ];

    this.args.isBorderVisible && classNames.push('pix-button--border');

    return classNames;
  }
}
