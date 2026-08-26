import { array } from '@ember/helper';
import { LinkTo } from '@ember/routing';

import PixButtonBase from './pix-button-base.gjs';
import PixButtonContent from './pix-button-content.gjs';

/**
 * @typedef {object} PixButtonLinkArgs
 * @property {string} [route] - Nom de la route Ember vers laquelle naviguer.
 * @property {unknown} [model] - Modèle transmis à la route.
 * @property {object} [query] - Paramètres de requête ajoutés à l'URL.
 * @property {boolean} [replace] - Remplace l'entrée courante de l'historique au lieu d'en ajouter une.
 * @property {string} [href] - URL de destination, pour un lien externe. Ignoré si `route` est fourni.
 * @property {'primary' | 'primary-white' | 'primary-bis' | 'secondary' | 'secondary-white' | 'tertiary' | 'tertiary-white' | 'success' | 'error' | 'transparent-dark'} [variant] - Rôle du lien dans la page, qui détermine ses couleurs. Par défaut : `primary`.
 * @property {'small' | 'large'} [size] - Hauteur et espacements du lien. Par défaut : `small`.
 * @property {boolean} [isDisabled] - Rend le lien inactif.
 * @property {boolean} [isBorderVisible] - Ajoute une bordure. N'a d'effet qu'avec la variante `transparent-dark`.
 * @property {string} [iconBefore] - Nom d'une icône affichée avant le libellé.
 * @property {string} [iconAfter] - Nom d'une icône affichée après le libellé.
 * @property {boolean} [plainIconBefore] - Affiche `iconBefore` dans sa variante pleine.
 * @property {boolean} [plainIconAfter] - Affiche `iconAfter` dans sa variante pleine.
 */

/**
 * @typedef {object} PixButtonLinkSignature
 * @property {HTMLAnchorElement} Element
 * @property {PixButtonLinkArgs} Args
 * @property {{ default: [] }} Blocks
 */

export default class PixButtonLink extends PixButtonBase {
  defaultModel = [];
  defaultParams = {};

  get className() {
    return super.baseClassNames.join(' ');
  }

  <template>
    {{#if @route}}
      <LinkTo
        @route={{@route}}
        @models={{if @model (array @model) this.defaultModel}}
        @disabled={{@isDisabled}}
        @query={{if @query @query this.defaultParams}}
        @replace={{@replace}}
        class={{this.className}}
        aria-disabled="{{@isDisabled}}"
        ...attributes
      >
        <PixButtonContent
          @iconBefore={{@iconBefore}}
          @iconAfter={{@iconAfter}}
          @plainIconAfter={{@plainIconAfter}}
          @plainIconBefore={{@plainIconBefore}}
        >
          {{yield}}
        </PixButtonContent>
      </LinkTo>
    {{else}}
      {{! template-lint-disable no-unsupported-role-attributes }}
      <a href={{@href}} class={{this.className}} aria-disabled="{{@isDisabled}}" ...attributes>
        <PixButtonContent
          @iconBefore={{@iconBefore}}
          @iconAfter={{@iconAfter}}
          @plainIconAfter={{@plainIconAfter}}
          @plainIconBefore={{@plainIconBefore}}
        >
          {{yield}}
        </PixButtonContent>
      </a>
    {{/if}}
  </template>
}
