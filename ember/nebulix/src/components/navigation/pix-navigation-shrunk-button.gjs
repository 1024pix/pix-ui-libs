import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { LinkTo } from '@ember/routing';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import PixIcon from '../graphics/pix-icon.gjs';

/**
 * @typedef {object} PixNavigationShrunkButtonArgs
 * @property {string} [route] - Nom de la route Ember vers laquelle naviguer.
 * @property {string} [icon] - Nom de l'icône affichée à la place du libellé.
 */

/**
 * @typedef {object} PixNavigationShrunkButtonSignature
 * @property {HTMLAnchorElement} Element
 * @property {PixNavigationShrunkButtonArgs} Args
 * @property {{ default: [] }} Blocks
 */

export default class PixNavigationShrunkButton extends Component {
  @tracked isTooltipVisible = false;

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
      <LinkTo
        @route={{@route}}
        class="pix-navigation-button navigation-shrunk-button"
        ...attributes
      >
        <PixIcon class="pix-navigation-button__icon" @ariaHidden={{true}} @name={{@icon}} />
      </LinkTo>
      <span role="tooltip" class="navigation-tooltip__content" aria-hidden="true">
        {{yield}}
      </span>
    </div>
  </template>
}
