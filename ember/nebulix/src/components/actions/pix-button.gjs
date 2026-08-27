import { warn } from '@ember/debug';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

import PixButtonBase from './pix-button-base.gjs';
import PixButtonContent from './pix-button-content.gjs';

/**
 * @typedef {object} PixButtonArgs
 * @property {'primary' | 'primary-white' | 'primary-bis' | 'secondary' | 'secondary-white' | 'tertiary' | 'tertiary-white' | 'success' | 'error' | 'transparent-dark'} [variant] - Rôle du bouton dans la page, qui détermine ses couleurs. Par défaut : `primary`.
 * @property {'small' | 'large'} [size] - Hauteur et espacements du bouton. Par défaut : `small`.
 * @property {'button' | 'submit' | 'reset'} [type] - Type natif du bouton. Par défaut : `button`.
 * @property {(event: MouseEvent) => unknown} [triggerAction] - Appelée au clic. Tant que la promesse retournée n'est pas résolue, le bouton affiche son chargeur et refuse les clics suivants. Obligatoire, sauf si `type` vaut `submit`.
 * @property {boolean} [isLoading] - Force l'état de chargement, indépendamment de `triggerAction`.
 * @property {'white' | 'grey'} [loadingColor] - Couleur du chargeur. Par défaut : `white`.
 * @property {boolean} [isDisabled] - Désactive le bouton.
 * @property {boolean} [isBorderVisible] - Ajoute une bordure. N'a d'effet qu'avec la variante `transparent-dark`.
 * @property {string} [iconBefore] - Nom d'une icône affichée avant le libellé.
 * @property {string} [iconAfter] - Nom d'une icône affichée après le libellé.
 * @property {boolean} [plainIconBefore] - Affiche `iconBefore` dans sa variante pleine.
 * @property {boolean} [plainIconAfter] - Affiche `iconAfter` dans sa variante pleine.
 */

/**
 * @typedef {object} PixButtonSignature
 * @property {HTMLButtonElement} Element
 * @property {PixButtonArgs} Args
 * @property {{ default: [] }} Blocks
 */

export default class PixButton extends PixButtonBase {
  text = 'pix-button';
  defaultModel = [];

  @tracked isTriggering = false;

  constructor(...args) {
    super(...args);

    const isTriggerFunctionExistOnTypedifferentOfSubmit =
      this.args.type !== 'submit' && typeof this.args.triggerAction === 'function';
    const isTriggerFunctionExistOrNullOnTypeSubmit =
      this.args.type === 'submit' &&
      (typeof this.args.triggerAction === 'function' ||
        this.args.triggerAction === undefined ||
        this.args.triggerAction === null);

    warn(
      'PixButton: @triggerAction attribute should be a function',
      isTriggerFunctionExistOnTypedifferentOfSubmit || isTriggerFunctionExistOrNullOnTypeSubmit,
      {
        id: 'pix-ui.button.action.not-function',
      },
    );
  }

  get isLoading() {
    warn(
      'PixButton: @isLoading attribute should be a boolean.',
      [true, false, undefined, null].includes(this.args.isLoading),
      {
        id: 'pix-ui.button.is-loading.not-boolean',
      },
    );

    return this.args.isLoading || this.isTriggering;
  }

  get type() {
    return this.args.type || 'button';
  }

  get loadingColor() {
    return this.args.loadingColor || this.args['loading-color'] || 'white';
  }

  get isDisabled() {
    warn(
      'PixButton: @isDisabled attribute should be a boolean.',
      [true, false, undefined, null].includes(this.args.isDisabled),
      {
        id: 'pix-ui.button.is-disabled.not-boolean',
      },
    );

    return this.isLoading || this.args.isDisabled ? 'true' : null;
  }

  get className() {
    return super.baseClassNames.join(' ');
  }

  @action
  async triggerAction(params) {
    if (this.isDisabled || (this.type === 'submit' && !this.args.triggerAction)) return;

    try {
      this.isTriggering = true;
      await this.args.triggerAction(params);
    } finally {
      this.isTriggering = false;
    }
  }

  <template>
    <button
      type={{this.type}}
      class={{this.className}}
      {{on "click" this.triggerAction}}
      aria-disabled="{{this.isDisabled}}"
      ...attributes
    >
      {{#if this.isLoading}}
        <div class="loader loader--{{this.loadingColor}}">
          <div class="bounce1"></div>
          <div class="bounce2"></div>
          <div class="bounce3"></div>
        </div>
        <span class="loader__not-visible-text">{{yield}}</span>
      {{else}}
        <PixButtonContent
          @iconBefore={{@iconBefore}}
          @iconAfter={{@iconAfter}}
          @plainIconAfter={{@plainIconAfter}}
          @plainIconBefore={{@plainIconBefore}}
        >
          {{yield}}
        </PixButtonContent>
      {{/if}}
    </button>
  </template>
}
