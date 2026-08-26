import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

import PixButtonBase from './pix-button-base.gjs';

/**
 * @typedef {object} PixButtonUploadArgs
 * @property {string} id - Identifiant du champ de fichier, repris par le libellé. Obligatoire.
 * @property {(files: FileList) => unknown} onChange - Appelée avec les fichiers choisis. Obligatoire.
 * @property {'primary' | 'primary-white' | 'primary-bis' | 'secondary' | 'secondary-white' | 'tertiary' | 'tertiary-white' | 'success' | 'error' | 'transparent-dark'} [variant] - Rôle du bouton dans la page, qui détermine ses couleurs. Par défaut : `primary`.
 * @property {'small' | 'large'} [size] - Hauteur et espacements du bouton. Par défaut : `small`.
 * @property {boolean} [isBorderVisible] - Ajoute une bordure. N'a d'effet qu'avec la variante `transparent-dark`.
 */

/**
 * @typedef {object} PixButtonUploadSignature
 * @property {HTMLInputElement} Element
 * @property {PixButtonUploadArgs} Args
 * @property {{ default: [] }} Blocks
 */

export default class PixButtonUpload extends PixButtonBase {
  @tracked
  files = [];

  get className() {
    return [...super.baseClassNames, 'pix-button-upload'].join(' ');
  }

  @action
  async handleChange(e) {
    if (e.target?.files?.length) {
      await this.args.onChange(e.target.files);
    }
    this.files = [];
  }

  <template>
    <label for={{@id}} class={{this.className}} role="button">
      {{yield}}
    </label>
    <input
      id={{@id}}
      type="file"
      class="screen-reader-only"
      value={{this.files}}
      {{on "change" this.handleChange}}
      ...attributes
    />
  </template>
}
