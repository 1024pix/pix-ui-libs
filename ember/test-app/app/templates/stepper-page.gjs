import { PixStepper } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';

export default class StepperPage extends Component {
  steps = [
    { title: 'Bonjour', subtitle: 'Ceci est une belle journée !' },
    { title: 'Bonjour', subtitle: 'Ceci est une belle journée !' },
    { title: 'Bonjour', subtitle: 'Ceci est une belle journée !' },
    { title: 'Bonjour', subtitle: 'Ceci est une belle journée !' },
    { title: 'Bonjour', subtitle: 'Ceci est une belle journée !' },
  ];
  <template><PixStepper @steps={{this.steps}} @currentStep={{3}} /></template>
}
