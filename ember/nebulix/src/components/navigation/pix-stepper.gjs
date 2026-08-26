import Component from '@glimmer/component';
import { eq } from 'ember-truth-helpers';

import { formatMessage } from '../../translations/index.js';
import PixStep from './pix-step.gjs';

/**
 * @typedef {object} PixStepperStep
 * @property {string} [title] - Intitulé de l'étape.
 * @property {string} [subtitle] - Précision affichée sous l'intitulé.
 */

/**
 * @typedef {object} PixStepperArgs
 * @property {PixStepperStep[]} steps - Étapes du parcours, dans l'ordre. Obligatoire.
 * @property {number} currentStep - Numéro de l'étape en cours, à partir de 1. Obligatoire.
 * @property {'fr' | 'en' | 'es' | 'es-419' | 'nl'} [locale] - Langue du résumé de progression lu par les lecteurs d'écran. Par défaut : `fr`.
 */

/**
 * @typedef {object} PixStepperSignature
 * @property {HTMLOListElement} Element
 * @property {PixStepperArgs} Args
 * @property {{}} Blocks
 */

export default class PixStepperComponent extends Component {
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

  get ariaLabel() {
    return formatMessage(this.args.locale ?? 'fr', 'stepper.ariaLabel', {
      current: this.args.currentStep,
      total: this.args.steps.length,
    });
  }

  <template>
    <ol class={{this.cssClass}} role="list" aria-label={{this.ariaLabel}} ...attributes>
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
