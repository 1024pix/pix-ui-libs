import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { LinkTo } from '@ember/routing';
import { fn } from '@ember/helper';
import { not } from 'ember-truth-helpers';
import { PixSidePanel, PixButton } from '@1024pix/nebulix-ember';

export default class SidePanelPage extends Component {
  @tracked showModal = false;
  title = "Filtrer";

  @action
  onClose() {}

  <template>
    <PixSidePanel
      @showSidePanel={{this.showSidePanel}}
      @title={{this.title}}
      @onClose={{fn (mut this.showSidePanel) (not this.showSidePanel)}}
      @subtitle="Barre latérale"
      @iconName="users"
    >
      <:content>
        <LinkTo @route="hello" class="internal-link">My link</LinkTo>
        <p>Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae
          pellentesque sem placerat..</p>
      </:content>
      <:footer>
        <PixButton
          @variant="secondary"
          @isBorderVisible="true"
          @triggerAction={{fn (mut this.showSidePanel) (not this.showSidePanel)}}
        >
          Annuler
        </PixButton>
        <PixButton
          @triggerAction={{fn (mut this.showSidePanel) (not this.showSidePanel)}}
        >Valider</PixButton>
      </:footer>
    </PixSidePanel>

    <PixButton @triggerAction={{fn (mut this.showSidePanel) (not this.showSidePanel)}}>Ouvrir le
      sidepanel
    </PixButton>
  </template>
}
