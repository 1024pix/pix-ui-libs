import { warn } from '@ember/debug';
import Component from '@glimmer/component';
import { eq } from 'ember-truth-helpers';

import PixStep from './pix-step.gjs';

/**
 * @typedef {object} PixStepperStep
 * @property {string} [title] - Intitulé de l'étape.
 * @property {string} [subtitle] - Précision affichée sous l'intitulé.
 */

/**
 * @typedef {object} PixStepperTexts
 * @property {string} ariaLabel - Résumé de la progression, lu par les lecteurs d'écran (ex. « Étape 2 sur 3 »). Obligatoire.
 */

/**
 * @typedef {object} PixStepperArgs
 * @property {PixStepperStep[]} steps - Étapes du parcours, dans l'ordre. Obligatoire.
 * @property {number} currentStep - Numéro de l'étape en cours, à partir de 1. Obligatoire.
 * @property {PixStepperTexts} texts - Textes affichés par le composant. À fournir par l'application consommatrice, dans la langue de son choix. Obligatoire.
 */

/**
 * @typedef {object} PixStepperSignature
 * @property {HTMLOListElement} Element
 * @property {PixStepperArgs} Args
 * @property {{}} Blocks
 */

export default class PixStepperComponent extends Component {
  constructor(...args) {
    super(...args);
    warn(
      'PixStepper: @texts attribute is mandatory for accessibility.',
      Boolean(this.args.texts?.ariaLabel),
      {
        id: 'pix-ui.stepper-component.texts.mandatory',
      },
    );
  }

  get cssClass() {
    const classes = ['pix-stepper'];

    if (this.args.steps.length > 3) {
      classes.push('pix-stepper--long');
    }

    return classes.join(' ');
  }

  get currentStepIndex() {
    return this.args.currentStep - 1;
  }

  <template>
    <ol class={{this.cssClass}} role="list" ...attributes aria-label={{@texts.ariaLabel}}>
      {{#each @steps as |step index|}}
        <PixStep
          @index={{index}}
          @title={{step.title}}
          @subtitle={{step.subtitle}}
          @isCurrent={{eq index this.currentStepIndex}}
        />
      {{/each}}
    </ol>
  </template>
}
