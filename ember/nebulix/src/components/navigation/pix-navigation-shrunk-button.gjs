import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { guidFor } from '@ember/object/internals';
import { LinkTo } from '@ember/routing';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import PixIcon from '../graphics/pix-icon.gjs';

/**
 * @typedef {object} PixNavigationShrunkButtonArgs
 * @property {string} [route] - Nom de la route Ember vers laquelle naviguer.
 * @property {string} [icon] - Nom de l'icône affichée à la place du libellé.
 * @property {boolean} [iconPlain] - Affiche l'icône dans sa variante pleine. Sans effet avec `route` : la variante pleine y signale la route active.
 */

/**
 * @typedef {object} PixNavigationShrunkButtonSignature
 * @property {HTMLAnchorElement} Element
 * @property {PixNavigationShrunkButtonArgs} Args
 * @property {{ default: [] }} Blocks
 */

export default class PixNavigationShrunkButton extends Component {
  @tracked isTooltipVisible = false;

  ariaDescribedBy = guidFor(this);

  @action
  showTooltip() {
    this.isTooltipVisible = true;
  }

  @action
  hideTooltip() {
    setTimeout(() => (this.isTooltipVisible = false));
  }

  @action
  hideTooltipOnMouseOut(event) {
    const isFocused = event.target.contains(document.activeElement);

    if (isFocused) {
      return;
    }

    this.hideTooltip(event);
  }

  <template>
    <div
      class="navigation-tooltip {{if this.isTooltipVisible 'navigation-tooltip--visible' ''}}"
      {{on "mouseleave" this.hideTooltipOnMouseOut}}
      {{on "mouseenter" this.showTooltip}}
      {{on "focusin" this.showTooltip}}
      {{on "focusout" this.hideTooltip}}
    >
      {{#if @route}}
        <LinkTo
          @route={{@route}}
          class="pix-navigation-button navigation-shrunk-button"
          aria-describedby={{this.ariaDescribedBy}}
          ...attributes
        >
          <PixIcon
            class="pix-navigation-button__icon"
            @ariaHidden={{true}}
            @name={{@icon}}
            @plainIcon={{@plainIcon}}
          />
        </LinkTo>
      {{else}}
        {{! template-lint-disable link-href-attributes }}
        <a
          class="pix-navigation-button navigation-shrunk-button"
          target={{if @isLinkOpenInANewWindow "_blank"}}
          aria-describedby={{this.ariaDescribedBy}}
          ...attributes
        >
          {{#if @icon}}
            <PixIcon
              class="pix-navigation-button__icon"
              @ariaHidden={{true}}
              @name={{@icon}}
              @plainIcon={{@plainIcon}}
            />
          {{/if}}
        </a>
      {{/if}}
      <span role="tooltip" class="navigation-tooltip__content" id={{this.ariaDescribedBy}}>
        {{yield}}

        {{#if @isLinkOpenInANewWindow}}
          <PixIcon
            class="pix-navigation-button__external-icon"
            @ariaHidden={{true}}
            @name="openNew"
          />
        {{/if}}
      </span>

    </div>
  </template>
}
