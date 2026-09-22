import { PixStepper } from '@1024pix/nebulix-ember';
import { action } from '@ember/object';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class StepperPage extends Component {
  steps = [
    { title: 'Étape 1', subtitle: "Ceci est l'étape 1" },
    { title: 'Étape 2', subtitle: "Ceci est l'étape 2" },
    { title: 'Étape 3', subtitle: "Ceci est l'étape 3" },
    { title: 'Étape 4', subtitle: "Ceci est l'étape 4" },
  ];

  @tracked currentStep = 3;

  get canNavigateTo() {
    const current = this.currentStep;
    return (stepNumber) => stepNumber < current;
  }

  @action
  goToStep(stepNumber) {
    this.currentStep = stepNumber;
  }
  <template>
    <p>Étape courante : {{this.currentStep}}</p>

    <h2>Non-navigable</h2>
    <PixStepper @steps={{this.steps}} @currentStep={{this.currentStep}} />

    <h2>Navigable</h2>
    <PixStepper
      @steps={{this.steps}}
      @currentStep={{this.currentStep}}
      @onStepClick={{this.goToStep}}
      @canNavigateTo={{this.canNavigateTo}}
    />
  </template>
}
