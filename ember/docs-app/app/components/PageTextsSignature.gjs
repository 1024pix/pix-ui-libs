import { service } from '@ember/service';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import { findTypeAlias, loadProject } from '../utils/typedoc-project';
import TextsSignature from './TextsSignature';

const PACKAGE = '@1024pix/nebulix-ember';

// A component's docs page lives at `/components/<category>/pix-x-y.md` and,
// by convention, its `@texts` argument (when it has one) is typed as
// `PixXYTexts` (see ember/nebulix/src/components/forms/pix-select.gjs).
// Deriving the typedef name from the URL this way means a new `@texts`
// typedef shows up here automatically, with nothing to register by hand.
function typeNameForPath(path) {
  const match = path?.match(/\/components\/[^/]+\/([^/]+)\.md$/);

  if (!match) return null;

  const pascalCase = match[1]
    .split('-')
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join('');

  return `${pascalCase}Texts`;
}

export default class PageTextsSignature extends Component {
  @service router;
  @tracked typeName = null;

  constructor(...args) {
    super(...args);
    this.load();
  }

  async load() {
    const candidate = typeNameForPath(this.router.currentURL);

    if (!candidate) return;

    const project = await loadProject(PACKAGE);

    if (findTypeAlias(project, candidate)) {
      this.typeName = candidate;
    }
  }

  <template>
    {{#if this.typeName}}
      <section class="texts-signature-frame">
        <h3 class="texts-signature__heading">{{this.typeName}}</h3>
        <TextsSignature @package={{PACKAGE}} @name={{this.typeName}} />
      </section>
    {{/if}}
  </template>
}
