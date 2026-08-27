import { warn } from '@ember/debug';
import Component from '@glimmer/component';

import PixBlock from '../layout/pix-block.gjs';

/**
 * @typedef {object} PixCardArgs
 * @property {string} title - Titre de la carte. Obligatoire : il est rendu dans un `<h3>`.
 * @property {string} [subtitle] - Sous-titre affiché sous le titre.
 * @property {string} [image] - URL d'une image d'illustration, affichée en tête de carte. Purement décorative : elle est masquée aux lecteurs d'écran.
 * @property {'primary' | 'admin' | 'orga' | 'certif'} [variant] - Application à laquelle la carte appartient, qui détermine ses couleurs. Par défaut : `orga`.
 * @property {boolean} [wide] - Étend la carte à toute la largeur disponible.
 */

/**
 * @typedef {object} PixCardSignature
 * @property {null} Element
 * @property {PixCardArgs} Args
 * @property {{ tag: [], description: [], footer: [] }} Blocks
 */

export default class PixCard extends Component {
  static get variants() {
    return ['primary', 'admin', 'orga', 'certif'];
  }

  get variant() {
    const value = this.args.variant ?? 'orga';
    warn(
      `PixCard: @variant "${value}" should be ${PixCard.variants.join(', ')}`,
      PixCard.variants.includes(value),
      {
        id: 'pix-ui.pix-card.variant.not-valid',
      },
    );

    return value;
  }

  get isWide() {
    return this.args.wide ?? false;
  }
  <template>
    <PixBlock @variant={{this.variant}} class="pix-card-wrapper">
      <article class="pix-card {{if this.isWide 'pix-card--wide'}}">
        {{#if @image}}
          <div class="pix-card__image pix-card__image--{{this.variant}}">
            <img src={{@image}} aria-hidden="true" alt="" />
          </div>
        {{/if}}
        <div class="pix-card__body">
          {{#if (has-block "tag")}}
            {{yield to="tag"}}
          {{/if}}
          <div class="pix-card__content">
            <header>
              <h3 class="pix-card__title pix-title-xxs" title={{@title}}>{{@title}}</h3>
              {{#if @subtitle}}
                <p title={{@subtitle}} class="pix-card__subtitle pix-subtitle-xxs">
                  {{@subtitle}}
                </p>
              {{/if}}
            </header>
            {{#if (has-block "description")}}
              <div class="pix-card__description pix-body-s">{{yield to="description"}}</div>
            {{/if}}
            {{#if (has-block "footer")}}
              <footer class="pix-card__footer pix-body-xs">{{yield to="footer"}}</footer>
            {{/if}}
          </div>
        </div>
      </article>
    </PixBlock>
  </template>
}
