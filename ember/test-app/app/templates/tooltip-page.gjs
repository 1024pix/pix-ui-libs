import './tooltip-page.css';

import { PixBlock, PixButton, PixInput, PixTooltip } from '@1024pix/nebulix-ember';
import { action } from '@ember/object';
import Component from '@glimmer/component';

export default class TooltipPage extends Component {
  @action
  onAction() {}

  <template>
    {{! template-lint-disable no-inline-styles }}
    <PixBlock class="block-container">
      <PixTooltip @id="id">
        <:triggerElement>
          <PixButton aria-describedby="id">
            Label
          </PixButton>
        </:triggerElement>

        <:tooltip>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut egestas molestie mauris vel
          viverra.
        </:tooltip>
      </PixTooltip>
    </PixBlock>
    <PixBlock class="block-container">
      <PixTooltip @id="id2">
        <:triggerElement>
          <PixInput @id="id3" @type="text" @placeholder="Placeholder">
            Label
          </PixInput>
        </:triggerElement>

        <:tooltip>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut egestas molestie mauris vel
          viverra.
        </:tooltip>
      </PixTooltip>
    </PixBlock>

    <PixBlock class="block-container">
      <PixTooltip @id="tooltip-button">
        <:triggerElement>
          <PixButton @triggerAction={{this.onAction}}>
            Label
          </PixButton>
        </:triggerElement>

        <:tooltip>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut egestas molestie mauris vel
          viverra.
        </:tooltip>
      </PixTooltip>
    </PixBlock>
  </template>
}
