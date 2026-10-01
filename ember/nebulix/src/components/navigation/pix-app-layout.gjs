import { warn } from '@ember/debug';
import { service } from '@ember/service';
import Component from '@glimmer/component';

import { VARIANTS } from '../../helpers/variants.js';
import onWindowResize from '../../modifiers/on-window-resize.js';

/**
 * @typedef {object} PixAppLayoutArgs
 * @property {'primary' | 'orga' | 'certif' | 'admin' | 'modulix'} [variant] - Application à laquelle la mise en page appartient, qui détermine ses couleurs. Par défaut : `primary`. La valeur `admin` active le bouton de repli de la navigation.
 * @property {boolean} hideNavBar - Cache la partie navigation dans la page en cours
 * @property {boolean} hideFooter - Cache la partie footer la page en cours
 * @property {boolean} isFullWidth - Prend 100% de la width dans pix-app-layout__main sans padding
 * @property {boolean} isStickyNavBar - Permet de passer la navigation en sticky afin qu'elle ne disparaisse pas au scroll.
 */

/**
 * @typedef {object} PixAppLayoutSignature
 * @property {HTMLDivElement} Element
 * @property {PixAppLayoutArgs} Args
 * @property {{ banner: [], navigation: [], main: [], footer: [] }} Blocks
 */

export default class PixAppLayout extends Component {
  @service shrinkNavigationService;

  #computeMarginTopElement(entries) {
    for (const entry of entries) {
      if (entry.target.id === 'pix-layout-banner-container') {
        const baseFontRemRatio = Number(
          getComputedStyle(document.querySelector('html')).fontSize.match(/\d+(\.\d+)?/)[0],
        );
        const bannerHeight = entry.target.getBoundingClientRect().height;
        const top = bannerHeight / baseFontRemRatio;

        const layoutElement = document.querySelector('.pix-app-layout');
        layoutElement?.style.setProperty('--pix-app-layout-top', `${top}rem`);
      }
    }
  }

  handleMarginContainerNavigation = (element) => {
    setTimeout(() => {
      this.#computeMarginTopElement(element);
    }, 0);
  };

  get variant() {
    const value = this.args.variant ?? 'primary';
    warn(
      `PixAppLayout: @variant "${value}" should be ${VARIANTS.join(', ')}`,
      VARIANTS.includes(value),
      {
        id: 'pix-ui.pix-app-layout.variant.not-valid',
      },
    );

    if (this.args.variant === 'admin') {
      this.shrinkNavigationService.displayShrunkNavigationButton();
    }

    return value;
  }
  get classNames() {
    const cssClassNames = ['pix-app-layout', `pix-app-layout--${this.variant}`];

    if (this.args.isFullWidth) {
      cssClassNames.push('pix-app-layout--without-padding');
    }

    if (this.args.hideFooter) {
      cssClassNames.push('pix-app-layout--without-footer');
    }

    if (this.args.hideNavBar) {
      cssClassNames.push('pix-app-layout--without-navigation');
    }

    if (this.args.hideFooter) {
      cssClassNames.push('pix-app-layout--without-footer');
    }

    if (this.args.isStickyNavBar) {
      cssClassNames.push('pix-app-layout--sticky-navigation');
    }

    return cssClassNames.join(' ');
  }

  <template>
    <div class={{this.classNames}} ...attributes>
      <section
        class="pix-app-layout__banner"
        id="pix-layout-banner-container"
        {{onWindowResize this.handleMarginContainerNavigation}}
      >
        {{yield to="banner"}}
      </section>
      <section class="pix-app-layout__navigation">{{yield to="navigation"}}</section>
      <main class="pix-app-layout__main">{{yield to="main"}}</main>
      <footer class="pix-app-layout__footer">{{yield to="footer"}}</footer>
    </div>
  </template>
}
