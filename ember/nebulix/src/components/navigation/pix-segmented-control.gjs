import { warn } from '@ember/debug';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { guidFor } from '@ember/object/internals';
import Component from '@glimmer/component';

import PixLabel from '../forms/pix-label.gjs';
import PixIcon from '../graphics/pix-icon.gjs';

/**
 * @typedef {object} PixSegmentedControlArgs
 * @property {boolean} toggled - Vue sélectionnée : `false` pour la première, `true` pour la seconde. Obligatoire.
 * @property {(toggled: boolean) => unknown} onChange - Appelée avec la nouvelle valeur au changement de vue. Obligatoire.
 * @property {string} [iconA] - Nom d'une icône affichée devant la première vue.
 * @property {string} [iconB] - Nom d'une icône affichée devant la seconde vue.
 * @property {'primary' | 'orga' | 'certif'} [variant] - Application à laquelle le sélecteur appartient, qui détermine ses couleurs. Par défaut : `primary`.
 * @property {'small' | 'default' | 'large'} [size] - Taille du libellé. Par défaut : `default`.
 * @property {string} [subLabel] - Complément d'information affiché sous le libellé.
 * @property {boolean} [screenReaderOnly] - Masque le libellé visuellement, tout en le laissant lisible par les lecteurs d'écran.
 * @property {boolean} [inlineLabel] - Place le libellé sur la même ligne que le sélecteur.
 */

/**
 * @typedef {object} PixSegmentedControlSignature
 * @property {null} Element
 * @property {PixSegmentedControlArgs} Args
 * @property {{ label: [], viewA: [], viewB: [] }} Blocks
 */

export default class PixSegmentedControl extends Component {
  get variant() {
    const value = this.args.variant ?? 'primary';
    const variantList = ['primary', 'orga', 'certif'];

    warn(
      `PixAppLayout: @variant "${value}" should be ${variantList.join(', ')}`,
      variantList.includes(value),
      {
        id: 'pix-ui.pix-segmented-control.variant.not-valid',
      },
    );

    return value;
  }

  get className() {
    const classes = ['pix-segmented-control', `pix-segmented-control--${this.variant}`];

    if (this.args.inlineLabel) {
      classes.push('pix-segmented-control--inline');
    }

    return classes.join(' ');
  }

  @action
  onChange() {
    this.args.onChange(!this.args.toggled);
  }

  get id() {
    return guidFor(this);
  }

  get toggleName() {
    return `${this.id}-toggle`;
  }

  get idViewA() {
    return `${this.id}-viewA`;
  }

  get idViewB() {
    return `${this.id}-viewB`;
  }

  get stateViewA() {
    return !this.args.toggled;
  }

  get stateViewB() {
    return this.args.toggled;
  }

  <template>
    <fieldset class={{this.className}} role="radiogroup">
      <PixLabel
        @useAsLegend={{true}}
        @screenReaderOnly={{@screenReaderOnly}}
        @subLabel={{@subLabel}}
        @size={{@size}}
        @inlineLabel={{@inlineLabel}}
      >
        {{yield to="label"}}
      </PixLabel>

      <div class="pix-segmented-control__radio">
        <label class="pix-segmented-control__radio-label" for={{this.idViewA}}>
          {{#if @iconA}}
            <PixIcon @name={{@iconA}} @plainIcon={{this.stateViewA}} @ariaHidden={{true}} />
          {{/if}}
          {{yield to="viewA"}}
          <input
            class="screen-reader-only"
            {{on "change" this.onChange}}
            id={{this.idViewA}}
            type="radio"
            name={{this.toggleName}}
            value="viewA"
            checked={{this.stateViewA}}
          />
        </label>
        <label class="pix-segmented-control__radio-label" for={{this.idViewB}}>
          {{#if @iconB}}
            <PixIcon @name={{@iconB}} @plainIcon={{this.stateViewB}} @ariaHidden={{true}} />
          {{/if}}
          {{yield to="viewB"}}
          <input
            class="screen-reader-only"
            {{on "change" this.onChange}}
            id={{this.idViewB}}
            type="radio"
            name={{this.toggleName}}
            value="viewB"
            checked={{this.stateViewB}}
          />
        </label>
      </div>
    </fieldset>
  </template>
}
