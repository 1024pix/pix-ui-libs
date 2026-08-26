import { array } from '@ember/helper';
import { LinkTo } from '@ember/routing';
import { service } from '@ember/service';
import Component from '@glimmer/component';

import PixIcon from '../graphics/pix-icon.gjs';
import PixNavigationShrunkButton from './pix-navigation-shrunk-button.gjs';

/**
 * @typedef {object} PixNavigationButtonArgs
 * @property {string} [route] - Nom de la route Ember vers laquelle naviguer. L'entrée est mise en avant lorsque cette route est celle affichée.
 * @property {unknown} [model] - Modèle transmis à cette route.
 * @property {object} [query] - Paramètres de requête ajoutés à l'URL.
 * @property {string} [icon] - Nom d'une icône affichée avant le libellé. Requis pour que l'entrée reste identifiable une fois la navigation repliée.
 * @property {boolean} [iconPlain] - Affiche l'icône dans sa variante pleine. Sans effet avec `route` : la variante pleine y signale la route active.
 */

/**
 * @typedef {object} PixNavigationButtonSignature
 * @property {HTMLAnchorElement} Element
 * @property {PixNavigationButtonArgs} Args
 * @property {{ default: [] }} Blocks
 */

export default class PixNavigationButton extends Component {
  defaultParams = {};
  defaultModel = [];
  @service router;
  @service shrinkNavigationService;

  get isActiveRoute() {
    return this.args.route === this.router.currentRouteName;
  }

  get isLinkOpenInANewWindow() {
    return this.args?.target === '_blank';
  }

  <template>
    {{#if this.shrinkNavigationService.isShrunk}}
      <PixNavigationShrunkButton
        @route={{@route}}
        @icon={{@icon}}
      >{{yield}}</PixNavigationShrunkButton>
    {{else}}
      {{#if @route}}
        <LinkTo
          @route={{@route}}
          @models={{if @model (array @model) this.defaultModel}}
          @query={{if @query @query this.defaultParams}}
          class="pix-navigation-button"
          target={{if this.isLinkOpenInANewWindow "_blank"}}
          ...attributes
        >
          {{#if @icon}}
            <PixIcon
              class="pix-navigation-button__icon"
              @ariaHidden={{true}}
              @name={{@icon}}
              @plainIcon={{if this.isActiveRoute true false}}
            />
          {{/if}}
          {{yield}}
          {{#if this.isLinkOpenInANewWindow}}
            <PixIcon
              class="pix-navigation-button__external-icon"
              @ariaHidden={{true}}
              @name="openNew"
            />
          {{/if}}
        </LinkTo>
      {{else}}
        {{! template-lint-disable link-href-attributes }}
        <a
          class="pix-navigation-button"
          target={{if this.isLinkOpenInANewWindow "_blank"}}
          ...attributes
        >
          {{#if @icon}}
            <PixIcon
              class="pix-navigation-button__icon"
              @ariaHidden={{true}}
              @name={{@icon}}
              @plainIcon={{@iconPlain}}
            />
          {{/if}}
          {{yield}}
          {{#if this.isLinkOpenInANewWindow}}
            <PixIcon
              class="pix-navigation-button__external-icon"
              @ariaHidden={{true}}
              @name="openNew"
            />
          {{/if}}
        </a>
      {{/if}}
    {{/if}}
  </template>
}
