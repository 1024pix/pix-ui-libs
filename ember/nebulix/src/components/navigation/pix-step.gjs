import Component from '@glimmer/component';

/**
 * @typedef {object} PixStepArgs
 * @property {number} index - Position de l'étape dans la liste, à partir de 0. Le numéro affiché en découle.
 * @property {string} [title] - Intitulé de l'étape.
 * @property {string} [subtitle] - Précision affichée sous l'intitulé.
 * @property {boolean} [isCurrent] - Désigne l'étape en cours.
 */

/**
 * @typedef {object} PixStepSignature
 * @property {HTMLLIElement} Element
 * @property {PixStepArgs} Args
 * @property {{}} Blocks
 */

export default class PixStepComponent extends Component {
  get cssClass() {
    const classes = ['pix-step'];

    if (this.args.isCurrent) {
      classes.push('pix-step--current');
    }

    return classes.join(' ');
  }

  get displayIndex() {
    return this.args.index + 1;
  }

  get ariaCurrent() {
    return this.args.isCurrent ? 'step' : null;
  }

  <template>
    <li class={{this.cssClass}} aria-current={{this.ariaCurrent}} ...attributes>
      <div class="pix-step__index" aria-hidden="true">
        {{this.displayIndex}}
      </div>
      {{#if @title}}
        <div class="pix-step__title">
          {{@title}}
        </div>
      {{/if}}
      {{#if @subtitle}}
        <div class="pix-step__subtitle">
          {{@subtitle}}
        </div>
      {{/if}}
    </li>
  </template>
}
