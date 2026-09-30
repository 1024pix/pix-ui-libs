import { PixTag } from '@1024pix/nebulix-ember';
import { action } from '@ember/object';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class TextareaPage extends Component {
  @tracked value = null;

  @action
  onTextarea(event) {
    this.value = event.target.value;
  }

  <template>
    <h1>PixTextArea</h1>
    <div
      style="background-color:var(--pix-neutral-0);gap:8px;display:flex;padding:8px;margin-bottom:20px"
    >

      <PixTag>
        Plop pouet ploup
      </PixTag>
      <PixTag @color="success-light" @iconBefore="checkCircle" @plainIcon={{true}}>
        Youpi !
      </PixTag>
      <PixTag @color="neutral" @iconAfter="help" @plainIcon={{true}}>
        Ben alors ?
      </PixTag>
    </div>

    <div style="background-color:var(--pix-neutral-0);gap:8px;display:flex;padding:8px">
      <PixTag
        @color="error-light"
        @iconBefore="cancel"
        @plainIcon={{true}}
        @size="small"
        @type="squircle"
        @textTransform="uppercase"
      >
        Raté essaie encore
      </PixTag>
      <PixTag
        @color="yellow-light"
        @iconBefore="copy"
        @plainIcon={{true}}
        @size="small"
        @type="squircle"
      >
        Brouillon
      </PixTag>
    </div>
  </template>
}
