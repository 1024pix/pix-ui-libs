import { array } from '@ember/helper';
import { LinkTo } from '@ember/routing';
import Component from '@glimmer/component';

import PixIcon from '../graphics/pix-icon.gjs';

/**
 * @typedef {object} PixBreadcrumbLink
 * @property {string} label - Texte du maillon.
 * @property {string} [route] - Nom de la route Ember vers laquelle naviguer. Sans route, le maillon est rendu comme la page courante.
 * @property {unknown} [model] - Modèle transmis à cette route.
 */

/**
 * @typedef {object} PixBreadcrumbArgs
 * @property {PixBreadcrumbLink[]} links - Maillons du fil d'Ariane, du plus général au plus précis. Obligatoire.
 */

/**
 * @typedef {object} PixBreadcrumbSignature
 * @property {HTMLElement} Element
 * @property {PixBreadcrumbArgs} Args
 * @property {{}} Blocks
 */

export default class PixBreadcrumb extends Component {
  defaultModel = [];

  get links() {
    return this.args.links.map((link) => ({
      ...link,
      label: link.label.trim(),
    }));
  }

  <template>
    <nav class="pix-breadcrumb" ...attributes>
      <ol>
        {{#each this.links as |link|}}
          {{#if link.route}}
            <li>
              <LinkTo
                @route={{link.route}}
                @models={{if link.model (array link.model) this.defaultModel}}
              >
                {{link.label}}
              </LinkTo>
              <PixIcon @name="chevronRight" @ariaHidden={{true}} />
            </li>
          {{else}}
            <li aria-current="page">
              <p>{{link.label}}</p>
            </li>
          {{/if}}
        {{/each}}
      </ol>
    </nav>
  </template>
}
