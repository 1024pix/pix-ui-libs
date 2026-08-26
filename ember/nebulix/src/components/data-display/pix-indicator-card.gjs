import { guidFor } from '@ember/object/internals';
import Component from '@glimmer/component';

import PixIcon from '../graphics/pix-icon.gjs';
import PixBlock from '../layout/pix-block.gjs';
import PixTooltip from '../overlay/pix-tooltip.gjs';

/**
 * @typedef {object} PixIndicatorCardArgs
 * @property {string} title - Ce que mesure l'indicateur. Obligatoire.
 * @property {string} iconName - Nom de l'icône illustrant l'indicateur. Obligatoire.
 * @property {boolean} [plainIcon] - Affiche l'icône dans sa variante pleine.
 * @property {'neutral' | 'grey' | 'primary' | 'blue' | 'success' | 'green' | 'tertiary' | 'purple' | 'warning'} [color] - Couleur du fond de l'icône. Par défaut : `grey`.
 * @property {string} [info] - Texte d'une infobulle explicitant le calcul de l'indicateur.
 * @property {string} [infoLabel] - Nom du déclencheur de cette infobulle, lu par les lecteurs d'écran.
 * @property {boolean} [isLoading] - Affiche le squelette de chargement à la place du contenu.
 * @property {string} [loadingMessage] - Message annoncé aux lecteurs d'écran pendant le chargement.
 */

/**
 * @typedef {object} PixIndicatorCardSignature
 * @property {HTMLDivElement} Element
 * @property {PixIndicatorCardArgs} Args
 * @property {{ default: [], sub: [] }} Blocks
 */

export default class PixIndicatorCard extends Component {
  id = guidFor(this);
  iconId = 'icon-' + this.id;
  tooltipId = 'tooltip-' + this.id;

  get color() {
    const { color } = this.args;
    if (!color) return `indicator-card__icon-wrapper--grey`;
    return `indicator-card__icon-wrapper--${color}`;
  }

  <template>
    <PixBlock @variant="orga" class="indicator-card" role="region" ...attributes>
      {{#if @isLoading}}
        <p class="screen-reader-only">{{@loadingMessage}}</p>
        <div class="indicator-card__icon" aria-hidden="true"></div>
        <div class="indicator-card__content" aria-hidden="true"></div>
      {{else}}
        <div id={{this.iconId}} class="indicator-card__icon-wrapper {{this.color}}">
          <PixIcon
            @name={{@iconName}}
            @plainIcon={{@plainIcon}}
            @ariaHidden={{true}}
            class="indicator-card__icon"
          />
        </div>
        <dl class="indicator-card__content">
          <div class="indicator-card__title">
            <dt>{{@title}}</dt>
            {{#if @info}}
              <PixTooltip
                @id={{this.tooltipId}}
                @position="top"
                @isWide={{true}}
                class="indicator-card__tooltip hide-on-mobile"
              >
                <:triggerElement>
                  <PixIcon
                    @name="info"
                    @plainIcon={{true}}
                    class="indicator-card__tooltip-icon"
                    tabindex="0"
                    aria-label={{@infoLabel}}
                    aria-describedby={{this.tooltipId}}
                  />
                </:triggerElement>
                <:tooltip>
                  {{@info}}
                </:tooltip>
              </PixTooltip>
            {{/if}}
          </div>
          <dd class="indicator-card__value">{{yield}}</dd>
          <p class="indicator-card__sub">
            {{yield to="sub"}}
          </p>
        </dl>
      {{/if}}
    </PixBlock>
  </template>
}
