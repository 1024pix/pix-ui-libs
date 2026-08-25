# PixModal

## Usage

```gjs live preview
import { PixButton, PixModal } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class ModalDemo extends Component {
  @tracked showModal = false;

  toggleModal = () => {
    this.showModal = !this.showModal;
  };

  <template>
    <PixButton @triggerAction={{this.toggleModal}}>Open the modal</PixButton>

    <PixModal
      @title="My modal"
      @showModal={{this.showModal}}
      @onCloseButtonClick={{this.toggleModal}}
    >
      <:content>
        Hello
      </:content>
      <:footer>
        <PixButton @triggerAction={{this.toggleModal}}>Close</PixButton>
      </:footer>
    </PixModal>
  </template>
}
```
