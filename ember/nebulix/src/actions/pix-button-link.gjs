import { array } from '@ember/helper';
import { LinkTo } from '@ember/routing';

import PixButtonContent from './pix-button-content.gjs';
import PixButtonBase from './pix-button-base.gjs';

export default class PixButtonLink extends PixButtonBase {
  defaultModel = [];
  defaultParams = {};

  get className() {
    return super.baseClassNames.join(' ');
  }

  <template>
    {{#if @route}}
      <LinkTo
        @route={{@route}}
        @models={{if @model (array @model) this.defaultModel}}
        @disabled={{@isDisabled}}
        @query={{if @query @query this.defaultParams}}
        @replace={{@replace}}
        class={{this.className}}
        aria-disabled="{{@isDisabled}}"
        ...attributes
      >
        <PixButtonContent
          @iconBefore={{@iconBefore}}
          @iconAfter={{@iconAfter}}
          @plainIconAfter={{@plainIconAfter}}
          @plainIconBefore={{@plainIconBefore}}
        >
          {{yield}}
        </PixButtonContent>
      </LinkTo>
    {{else}}
      {{! template-lint-disable no-unsupported-role-attributes }}
      <a href={{@href}} class={{this.className}} aria-disabled="{{@isDisabled}}" ...attributes>
        <PixButtonContent
          @iconBefore={{@iconBefore}}
          @iconAfter={{@iconAfter}}
          @plainIconAfter={{@plainIconAfter}}
          @plainIconBefore={{@plainIconBefore}}
        >
          {{yield}}
        </PixButtonContent>
      </a>
    {{/if}}
  </template>
}
