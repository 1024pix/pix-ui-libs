import './button-page.css';

import { PixButton, PixIconButton, PixSegmentedControl } from '@1024pix/nebulix-ember';
import { action } from '@ember/object';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class ButtonPage extends Component {
  @tracked toggleSegmentedControl = false;

  @action
  onClick() {
    // eslint-disable-next-line no-console
    console.log('CLICKED');
  }

  @action
  onChangeSegmentedControl() {
    this.toggleSegmentedControl = !this.toggleSegmentedControl;
    // eslint-disable-next-line no-console
    console.log('toggleSegmentedControl', this.toggleSegmentedControl);
  }

  get toggleSegmentedControlValue() {
    return this.toggleSegmentedControl;
  }

  <template>
    <PixIconButton
      @ariaLabel="Mon joli bouton"
      @iconName="conversionPath"
      @triggerAction={{this.onClick}}
    />

    <PixIconButton
      @ariaLabel="Mon joli bouton"
      @iconName="conversionPath"
      @triggerAction={{this.onClick}}
      @isDisabled={{true}}
    />

    {{! template-lint-disable no-inline-styles }}
    <div class="button-page__container">
      <PixButton @triggerAction={{this.onClick}} @variant="primary-white">Bouton primaire blanc</PixButton>

      <PixButton
        @triggerAction={{this.onClick}}
        @variant="primary-white"
        @isDisabled={{true}}
      >Bouton primaire blanc</PixButton>

      <PixButton @triggerAction={{this.onClick}} @variant="secondary-white">Bouton secondaire blanc</PixButton>

      <PixButton
        @triggerAction={{this.onClick}}
        @variant="secondary-white"
        @isDisabled={{true}}
      >Bouton secondaire blanc</PixButton>

      <PixButton @triggerAction={{this.onClick}} @variant="tertiary-white">Bouton tertiaire blanc</PixButton>

      <PixButton
        @triggerAction={{this.onClick}}
        @variant="tertiary-white"
        @isDisabled={{true}}
      >Bouton tertiaire blanc</PixButton>

      <PixSegmentedControl
        @toggled={{this.toggleSegmentedControlValue}}
        @onChange={{this.onChangeSegmentedControl}}
        @iconA="book"
        @iconB="lightBulb"
      >
        <:label>Mon segemented control</:label>
        <:viewA>Oui</:viewA>
        <:viewB>Non</:viewB>
      </PixSegmentedControl>
    </div>
  </template>
}
