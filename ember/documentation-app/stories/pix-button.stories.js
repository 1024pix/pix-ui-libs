import { hbs } from 'ember-cli-htmlbars';

export default {
  title: 'Actions/Button',
  argTypes: {
    type: {
      name: 'type',
      description: 'type du bouton',
      type: { required: false },
      control: { disable: true },
      table: {
        type: { summary: 'string' },
        defaultValue: { summary: 'button' },
      },
    },
    triggerAction: {
      name: 'triggerAction',
      description: 'fonction à appeler en cas de clic, optionnel si le bouton est de type submit',
      type: { required: true },
      control: { disable: true },
    },
    loadingColor: {
      name: 'loadingColor',
      description: 'couleur de chargement: `white`, `grey`',
      type: { name: 'string', required: false },
      options: ['white', 'grey'],
      control: { type: 'select' },
      table: {
        type: { summary: 'string' },
        defaultValue: { summary: 'white' },
      },
    },
    variant: {
      name: 'variant',
      description: 'Permet le choix de la déclinaison du bouton souhaité',
      options: [
        'primary',
        'primary-bis',
        'primary-white',
        'secondary',
        'secondary-white',
        'tertiary',
        'tertiary-white',
        'success',
        'error',
        'transparent-dark',
      ],
      type: { name: 'string', required: false },
      control: { type: 'select' },
      table: {
        type: { summary: 'string' },
        defaultValue: { summary: 'primary' },
      },
    },
    plainIconBefore: {
      name: 'plainIconBefore',
      description: `Change le type de l'icône **avant** le label en fill/plain`,
      type: { name: 'boolean', required: false },
      table: {
        type: { summary: 'boolean' },
        defaultValue: { summary: 'false' },
      },
    },
    plainIconAfter: {
      name: 'plainIconAfter',
      description: `Change le type de l'icône **après** le label fill/plain`,
      type: { name: 'boolean', required: false },
      table: {
        type: { summary: 'boolean' },
        defaultValue: { summary: 'false' },
      },
    },
    isDisabled: {
      name: 'isDisabled',
      type: { name: 'boolean', required: false },
      control: { type: 'boolean' },
      table: {
        type: { summary: 'boolean' },
        defaultValue: { summary: 'false' },
      },
    },
    isLoading: {
      name: 'isLoading',
      description:
        'Affiche un loader. Si `@triggerAction` retourne une promesse alors le loading est géré automatiquement.',
      type: { name: 'boolean', required: false },
      control: { type: 'boolean' },
      table: {
        type: { summary: 'boolean' },
        defaultValue: { summary: 'false' },
      },
    },
    size: {
      name: 'size',
      description: 'taille: `large`,`small`',
      options: ['large', 'small'],
      type: { name: 'string', required: false },
      control: { type: 'select' },
      table: {
        type: { summary: 'string' },
        defaultValue: { summary: 'small' },
      },
    },
    isBorderVisible: {
      name: 'isBorderVisible',
      description:
        'Paramètre utilisé seulement quand le `variant` est `secondary` ou `transparent-dark`',
      type: { name: 'boolean', required: false },
      control: { type: 'boolean' },
      table: {
        type: { summary: 'boolean' },
        defaultValue: { summary: 'false' },
      },
    },
  },
};

const Template = (args) => ({
  template: hbs`<section style={{this.style}}>
  <PixButton
    @triggerAction={{this.triggerAction}}
    @loadingColor={{this.loadingColor}}
    @variant={{this.variant}}
    @isDisabled={{this.isDisabled}}
    @isLoading={{this.isLoading}}
    @size={{this.size}}
    @isBorderVisible={{this.isBorderVisible}}
    @iconBefore={{this.iconBefore}}
    @iconAfter={{this.iconAfter}}
    @plainIconBefore={{this.plainIconBefore}}
    @plainIconAfter={{this.plainIconAfter}}
  >
    {{this.label}}
  </PixButton>
</section>
{{#each this.extraButtons as |button|}}
  <section style={{button.style}}>
    <PixButton
      @triggerAction={{this.triggerAction}}
      @loadingColor={{button.loadingColor}}
      @variant={{button.variant}}
      @isDisabled={{button.isDisabled}}
      @isLoading={{button.isLoading}}
      @size={{button.size}}
      @isBorderVisible={{button.isBorderVisible}}
      @iconBefore={{button.iconBefore}}
      @iconAfter={{button.iconAfter}}
      @plainIconBefore={{this.plainIconBefore}}
      @plainIconAfter={{this.plainIconAfter}}
    >
      {{button.label}}
    </PixButton>
  </section>
{{/each}}`,
  context: args,
});

export const Default = Template.bind({});
Default.args = {
  loadingColor: 'white',
  variant: 'primary',
  label: 'Bouton',
};
