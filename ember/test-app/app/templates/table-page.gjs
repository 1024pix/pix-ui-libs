import './table-page.css';

import {
  PixButtonLink,
  PixCheckbox,
  PixIcon,
  PixTable,
  PixTableColumn,
  PixTag,
} from '@1024pix/nebulix-ember';
import { concat } from '@ember/helper';
import { action } from '@ember/object';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class TablePage extends Component {
  @tracked
  nameSortOrder = null;
  @tracked
  numSortOrder = null;

  variant = 'orga';

  @tracked
  data = [
    {
      name: 'jean',
      description: 'fort au jungle speed',
      age: 15,
      link: {
        label: 'PixApp',
        url: 'https://app.pix.fr',
      },
    },
    {
      name: 'brian',
      description: 'travail au peach pit',
      age: 25,
      link: {
        label: 'Ecosia',
        url: 'https://www.ecosia.org',
      },
    },
  ];

  caption = 'Titre de mon tableau';

  @action
  onNameSort() {
    this.resetOrders('name');
    if (this.nameSortOrder === 'asc') {
      this.data = this.data.sort((a, b) => b.name.localeCompare(a.name));
      this.nameSortOrder = 'desc';
    } else {
      this.data = this.data.sort((a, b) => a.name.localeCompare(b.name));
      this.nameSortOrder = 'asc';
    }
  }

  @action
  onClick() {}

  @action
  onNumSort() {
    this.resetOrders('num');
    if (this.numSortOrder === 'asc') {
      this.data = this.data.sort((a, b) => b.age - a.age);
      this.numSortOrder = 'desc';
    } else {
      this.data = this.data.sort((a, b) => a.age - b.age);
      this.numSortOrder = 'asc';
    }
  }

  resetOrders(except) {
    for (const key of ['num', 'name']) {
      if (key === except) continue;
      this[`${key}SortOrder`] = null;
    }
  }
  <template>
    <PixTable
      @variant={{this.variant}}
      @data={{this.data}}
      @caption={{this.caption}}
      @onRowClick={{this.onClick}}
    >
      <:columns as |row context|>
        <PixTableColumn @context={{context}} @type="checkbox">
          <:header>
            <PixCheckbox
              @id="select-all-{{row.id}}"
              @checked={{row.checked}}
              @screenReaderOnly={{true}}
              @size="small"
            >
              <:label>Sélectionner toutes les lignes</:label>
            </PixCheckbox>
          </:header>
          <:cell>
            <PixCheckbox
              @id={{row.id}}
              @checked={{row.checked}}
              @screenReaderOnly={{true}}
              @size="small"
            >
              <:label>Sélectionner {{row.nom}}</:label>
            </PixCheckbox>
          </:cell>
        </PixTableColumn>
        <PixTableColumn
          @context={{context}}
          @type="text"
          @onSort={{this.onNameSort}}
          @sortOrder={{this.nameSortOrder}}
        >
          <:header>
            Nom
          </:header>
          <:cell>
            {{row.name}}
          </:cell>
        </PixTableColumn>
        <PixTableColumn @context={{context}}>
          <:header>
            Description
          </:header>
          <:cell>
            <i>{{row.description}}</i>
          </:cell>
        </PixTableColumn>
        <PixTableColumn
          @context={{context}}
          @type="number"
          @onSort={{this.onNumSort}}
          @sortOrder={{this.numSortOrder}}
          class="table__column--small"
        >
          <:header>
            Age
          </:header>
          <:cell>
            {{row.age}}
          </:cell>
        </PixTableColumn>
        <PixTableColumn @context={{context}} class="table__column--small">
          <:header>
            Info
          </:header>
          <:cell>
            <PixIcon @name="info" @title={{concat row.name " a " row.age " ans"}} />
          </:cell>
        </PixTableColumn>
        <PixTableColumn @context={{context}} @type="tag">
          <:header>
            Tag
          </:header>
          <:cell>
            <PixTag>
              Un tag
            </PixTag>
          </:cell>
        </PixTableColumn>
        <PixTableColumn @context={{context}} @type="tagDate">
          <:header>
            Tag + date
          </:header>
          <:cell>
            <PixTag>
              Un tag
            </PixTag>
          </:cell>
          <:subCell>01/01/1970</:subCell>
        </PixTableColumn>
        <PixTableColumn @context={{context}} @type="link">
          <:header>
            Link
          </:header>
          <:cell>
            <PixButtonLink
              @href={{row.link.url}}
              target="_blank"
              @variant="tertiary"
              @iconBefore="openNew"
            >
              {{row.link.label}}
            </PixButtonLink>
          </:cell>
        </PixTableColumn>

      </:columns>
    </PixTable>
  </template>
}
