import Component from '@glimmer/component';
import { humanize } from 'docs-app/utils/humanize';
import { docsManager } from 'kolay';

/**
 * Kolay's implicit group: the pages co-located in `app/templates`. This app
 * has none — `/` opens the Nebulix docs instead — but the group is always
 * part of the manifest, so its link is filtered out here. Kolay does not
 * export the name, hence the literal.
 */
const HOME_GROUP = 'Home';

/**
 * The header navigation: one link per docs group declared in
 * `kolay.config.js`. Replaces kolay's own `GroupNav`, which always renders a
 * `Home` link.
 */
export default class DocsGroupNav extends Component {
  get #docs() {
    return docsManager(this);
  }

  get groups(): { name: string; label: string; href: string; isActive: boolean }[] {
    return this.#docs.availableGroups
      .filter((name) => name !== HOME_GROUP)
      .map((name) => ({
        name,
        label: humanize(name),
        href: this.#docs.groupHrefFor(name),
        isActive: this.#docs.selectedGroup === name,
      }));
  }

  <template>
    <nav aria-label="Groups">
      <ul>
        {{#each this.groups key="name" as |group|}}
          <li>
            <a href={{group.href}} class={{if group.isActive "active"}}>{{group.label}}</a>
          </li>
        {{/each}}
      </ul>
    </nav>
  </template>
}
