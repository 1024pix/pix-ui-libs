import { PixButton, PixModal } from '@1024pix/nebulix-ember';
import { fn } from '@ember/helper';
import { action } from '@ember/object';
import { LinkTo } from '@ember/routing';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { not } from 'ember-truth-helpers';

export default class ModalPage extends Component {
  @tracked showModal = false;
  title = "Qu'est-ce qu'une modale ?";

  @action
  onCloseButtonClick() {}

  <template>
    <PixModal
      @showModal={{this.showModal}}
      @title={{this.title}}
      @onCloseButtonClick={{fn (mut this.showModal) (not this.showModal)}}
      @iconName="hearing"
      @subtitle="Voici le sous-titre de cette modale."
    >
      <:content>
        <LinkTo @route="hello" class="internal-link">My link</LinkTo>
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Saepe velit animi, non voluptate
          assumenda ratione voluptas est consequatur qui voluptatibus tempore explicabo, harum
          deserunt corporis molestiae, distinctio adipisci facere itaque.</p>
      </:content>
      <:footer>
        <PixButton
          @variant="secondary"
          @isBorderVisible="true"
          @triggerAction={{fn (mut this.showModal) (not this.showModal)}}
        >
          Annuler
        </PixButton>
        <PixButton @triggerAction={{fn (mut this.showModal) (not this.showModal)}}>
          Valider
        </PixButton>
      </:footer>
    </PixModal>

    <PixButton @triggerAction={{fn (mut this.showModal) (not this.showModal)}}>Ouvrir la modale</PixButton>
  </template>
}
