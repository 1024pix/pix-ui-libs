import { PixTextarea } from '@1024pix/nebulix-ember';
import { action } from '@ember/object';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';

export default class TextareaPage extends Component {
  @tracked value = null;

  @action
  onTextarea(event) {
    this.value = event.target.value;
  }

  <template>
    <h1>PixTextArea</h1>
    <div style="display: flex; flex-direction: column; gap: 2rem;">
      <PixTextarea
        {{on "change" this.onTextarea}}
        @value={{this.value}}
        @placeholder="Select an option"
        @requiredLabel="Required"
        @maxlength="500"
      >
        <:label>Saisie ton texte Broooo</:label>
      </PixTextarea>
    </div>
  </template>
}
