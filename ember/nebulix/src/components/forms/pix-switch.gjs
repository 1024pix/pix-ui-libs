import { warn } from '@ember/debug';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { guidFor } from '@ember/object/internals';
import Component from '@glimmer/component';

/**
 * @typedef {object} PixSwitchArgs
 * @property {string} [id] - Identifiant du switch. Généré automatiquement s'il n'est pas fourni.
 * @property {boolean} [checked] - Active le switch.
 * @property {boolean} [isDisabled] - Désactive le switch.
 * @property {'admin' | 'orga' | 'certif'} [variant] - Couleur du switch activé. Par défaut : `admin`.
 * @property {'small' | 'medium' | 'large'} [size] - Taille du switch. Par défaut : `medium`.
 * @property {string} [class] - Classes CSS ajoutées au conteneur.
 */

/**
 * @typedef {object} PixSwitchSignature
 * @property {HTMLInputElement} Element
 * @property {PixSwitchArgs} Args
 * @property {{ default: [] }} Blocks
 */

export default class PixSwitch extends Component {
  constructor() {
    super(...arguments);
  }

  get id() {
    return this.args.id || guidFor(this);
  }

  get variant() {
    const value = this.args.variant ?? 'admin';

    warn(
      `PixSwitch: @variant "${value}" should be admin, orga, or certif`,
      ['admin', 'orga', 'certif'].includes(value),
      {
        id: 'pix-ui.pix-switch.variant.not-valid',
      },
    );

    return value;
  }

  get size() {
    const value = this.args.size ?? 'medium';

    warn(
      `PixSwitch: @size "${value}" should be small, medium, or large`,
      ['small', 'medium', 'large'].includes(value),
      {
        id: 'pix-ui.pix-switch.size.not-valid',
      },
    );

    return value;
  }

  get isDisabledBoolean() {
    return this.args.isDisabled || this.args.disabled ? true : false;
  }

  get isDisabledAria() {
    return this.isDisabledBoolean ? 'true' : null;
  }

  get inputClasses() {
    const classes = [
      'pix-switch__input',
      `pix-switch__input--variant-${this.variant}`,
      `pix-switch__input--size-${this.size}`,
    ];

    return classes.join(' ');
  }

  @action
  handleChange(event) {
    if (this.isDisabledBoolean) {
      event.preventDefault();
      return;
    }
  }

  <template>
    <div class="pix-switch {{@class}}">
      <input
        type="checkbox"
        id={{this.id}}
        class={{this.inputClasses}}
        checked={{@checked}}
        disabled={{this.isDisabledBoolean}}
        aria-disabled={{this.isDisabledAria}}
        role="switch"
        aria-checked={{if @checked "true" "false"}}
        {{on "change" this.handleChange}}
        ...attributes
      />
      <label for={{this.id}} class="pix-switch__label"></label>
    </div>
  </template>
}
