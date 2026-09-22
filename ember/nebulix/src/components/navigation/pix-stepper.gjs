import { warn } from '@ember/debug';
import { fn } from '@ember/helper';
import Component from '@glimmer/component';

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
 * @property {(stepNumber: number) => void} [onStepClick] - Callback appelé avec le numéro de l'étape au clic. Active le mode navigation. Sans cette prop, le composant est non-interactif.
 * @property {(stepNumber: number) => boolean} [canNavigateTo] - Fonction optionnelle qui détermine si une étape est cliquable. Reçoit le numéro d'une étape et retourne `true` si elle doit être cliquable. Sans cette prop, toutes les étapes sont cliquables dès que `@onStepClick` est fourni.
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

  get stepsWithState() {
    const { onStepClick, canNavigateTo, steps, currentStep } = this.args;
    const currentStepIndex = currentStep - 1;

    return steps.map((step, index) => {
      const stepNumber = index + 1;
      const isClickable = onStepClick ? (canNavigateTo ? canNavigateTo(stepNumber) : true) : false;

      return { ...step, stepNumber, isCurrent: index === currentStepIndex, isClickable };
    });
  }

  <template>
    <ol class={{this.cssClass}} role="list" ...attributes aria-label={{@texts.ariaLabel}}>
      {{#each this.stepsWithState as |step index|}}
        <PixStep
          @index={{index}}
          @title={{step.title}}
          @subtitle={{step.subtitle}}
          @isCurrent={{step.isCurrent}}
          @isClickable={{step.isClickable}}
          @onClick={{if step.isClickable (fn @onStepClick step.stepNumber)}}
        />
      {{/each}}
    </ol>
  </template>
}
