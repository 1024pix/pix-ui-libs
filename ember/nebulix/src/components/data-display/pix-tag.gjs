import Component from '@glimmer/component';

import { formatMessage } from '../../translations/index.js';
import PixIconButton from '../actions/pix-icon-button.gjs';

import "./pix-tag.scss";

export default class PixTag extends Component {
  get classes() {
    const { color } = this.args;
    const classes = [];
    if (color) classes.push(`pix-tag--${color}`);
    return classes.join(' ');
  }

  get ariaLabel() {
    return formatMessage(this.args.locale || 'fr', 'tag.removeButton');
  }

  <template>
    <div class="pix-tag {{this.classes}}" ...attributes>
      {{yield}}
      {{#if @displayRemoveButton}}
        <PixIconButton
          @ariaLabel={{this.ariaLabel}}
          @iconName="close"
          @size="xsmall"
          @triggerAction={{@onRemove}}
        />
      {{/if}}
    </div>
  </template>
}
