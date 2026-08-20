import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { LinkTo } from '@ember/routing';
import { PixSelect, PixButton, PixMultiSelect, PixPagination } from '@1024pix/nebulix-ember';

export default class SelectPage extends Component {
  @tracked selectedOption = null;
  @tracked structure = this.structures[1];
  @tracked multiValues = [];
  @tracked countriesError = true;
  @tracked selectedCountry = null;
  @tracked options = [
    {
      value: '1',
      label: 'Figues',
      category: 'rouge',
      icon: 'accountOff',
      iconTitle: 'titre icone account',
    },
    {
      value: '3',
      label:
        'Fraises, des bonnes fraises, bien rouge. Tout un gros paquet de fraises, mais beaucoup beaucoup',
      category: 'rouge',
      icon: 'userCircle',
      iconTitle: 'titre icone user',
    },
    { value: '2', label: 'Bananes', category: 'jaune' },
    { value: '4', label: 'Mangues', category: 'jaune' },
    { value: '5', label: 'Kaki', category: 'vert' },
    {
      value: '6',
      label: 'Asiminier trilobé oblong vert (à ne pas confondre avec la papaye)',
      category: 'vert',
    },
  ];
  @tracked multiOptions = [
    { value: 'a', label: 'Salade'},
    { value: 'b', label: 'Tomate'},
    { value: 'c', label: 'Oignons'},
  ]
  @tracked searchValue;
  @tracked multiSearchValue;

  @action
  onChange(option) {
    this.selectedOption = option;
  }

  @action
  onChangeCountry(option) {
    this.selectedCountry = option;
    this.countriesError = false;
  }

  @action
  onMultiChange(values) {
    this.multiValues = values;
  }

  @action
  setStructure(option) {
    this.structure = option;
  }

  @action
  addNewOption() {
    if (this.options.length > 6) return;
    const newOption = { value: '7', label: 'Citron', category: 'yellow' };
    this.options = [...this.options, newOption]
  }

  @action
  addNewMultiOption() {
    if (this.multiOptions.length > 3) return;
    const newOption = { value: 'd', label: 'Harissa (NEW)' };
    this.multiOptions = [...this.multiOptions, newOption]
  }

  @action
  onSearch(search) {
    this.searchValue = search;
  }

  @action
  onMultiSearch(search) {
    this.multiSearchValue = search;
  }

  countriesOptions = [
    { value: '1', label: 'England' },
    { value: '2', label: 'Cambodgia' },
    { value: '3', label: 'South Africa' },
  ];

  get options() {
    return
  }

  get filteredOptions() {
    if (this.searchValue) {
      try {
        const searchRegex = new RegExp(`${this.searchValue}`, 'i')
        return this.options.filter((option) => option.label.match(searchRegex));
      } catch {}
    }
    return this.options;
  }

  get filteredMultiOptions() {
    if (this.multiSearchValue) {
      try {
        const searchRegex = new RegExp(`${this.multiSearchValue}`, 'i')
        return this.multiOptions.filter((option) => option.label.match(searchRegex));
      } catch {}
    }
    return this.multiOptions;
  }

  get pagination() {
    return {
      page: 1,
      pageSize: 5,
      rowCount: 12,
      pageCount: 3,
    };
  }

  <template>
    <h1>PixSelect</h1>
    <div style="display: flex; flex-direction: column; gap: 2rem;">
      <div class="single-select">
        <PixSelect
          @options={{this.filteredOptions}}
          @onChange={{this.onChange}}
          @value={{this.selectedOption}}
          @hideDefaultOption={{true}}
          @placeholder="Select an option"
          @isSearchable={{true}}
          @onSearch={{this.onSearch}}
        >
          <:label>Fruits</:label>
        </PixSelect>
        <PixButton @triggerAction={{this.addNewOption}}>Ajouter un citron</PixButton>
      </div>

      <div class="multi-select">
        <PixMultiSelect
          @options={{this.filteredMultiOptions}}
          @values={{this.multiValues}}
          @onChange={{this.onMultiChange}}
          @onSearch={{this.onMultiSearch}}
          @isSearchable={{true}}
          @placeholder="Rechercher une option"
          @searchPlaceholder="Euuuuuh"
          @emptySearchMessage="Aucun résultat"
          @emptyMessage="Pas d'options"
          class="full"
        >
          <:label>Kebab</:label>
          <:default as |option|>{{option.label}}</:default>
        </PixMultiSelect>
        <PixButton @triggerAction={{this.addNewMultiOption}}>Ajouter une option</PixButton>
      </div>

      <div class="select-page__bordered-container">
        <PixSelect
          class="select-page__country-select"
          @options={{this.countriesOptions}}
          @onChange={{this.onChangeCountry}}
          @value={{this.selectedCountry}}
          @hideDefaultOption={{true}}
          @placeholder="Select an option"
          @requiredLabel="Required"
          @errorMessage={{if this.countriesError "You must select a country"}}
          {{!-- @isFullWidth={{true}} --}}
          @inlineLabel={{true}}
        >
          <:label>Countries</:label>
        </PixSelect>
      </div>

      <PixPagination @pagination={{this.pagination}} />
    </div>
  </template>
}
