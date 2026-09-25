import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

import { findTypeAlias, loadProject } from '../utils/typedoc-project';

function toDescription(comment) {
  if (!comment?.summary?.length) return [];

  const segments = comment.summary.map((part) => ({
    isCode: part.kind === 'code',
    text: part.kind === 'code' ? part.text.replace(/^`|`$/g, '') : part.text,
  }));

  // JSDoc's `@property {type} name - description` convention leaves a
  // leading "- " on the first text segment; strip it for display.
  if (segments[0] && !segments[0].isCode) {
    segments[0] = { ...segments[0], text: segments[0].text.replace(/^-\s*/, '') };
  }

  return segments;
}

export default class TextsSignature extends Component {
  @tracked fields = null;
  @tracked isMissing = false;

  constructor(...args) {
    super(...args);
    this.load();
  }

  async load() {
    const project = await loadProject(this.args.package);
    const typeAlias = findTypeAlias(project, this.args.name);

    if (!typeAlias) {
      this.isMissing = true;

      return;
    }

    this.fields = typeAlias.children.map((child) => ({
      name: child.name,
      type: child.type?.name ?? child.type?.type ?? '?',
      isOptional: Boolean(child.flags?.isOptional),
      description: toDescription(child.comment),
    }));
  }

  <template>
    <div class="texts-signature">
      {{#if this.isMissing}}
        <p>Type
          <code>{{@name}}</code>
          introuvable dans la documentation générée.</p>
      {{else if this.fields}}
        {{#each this.fields as |field|}}
          <span class="texts-signature__arg">
            <span class="texts-signature__arg-info">
              <pre class="texts-signature__name">{{field.name}}</pre>
              <span class="texts-signature__type">{{field.type}}</span>
            </span>

            <span class="texts-signature__flags">
              {{#if field.isOptional}}
                <span class="texts-signature__flag">optional</span>
              {{else}}
                <span class="texts-signature__flag texts-signature__flag--required">required</span>
              {{/if}}
            </span>

            {{#if field.description.length}}
              <div class="texts-signature__comment">
                <p>
                  {{#each field.description as |segment|}}
                    {{#if segment.isCode}}<code
                      >{{segment.text}}</code>{{else}}{{segment.text}}{{/if}}
                  {{/each}}
                </p>
              </div>
            {{/if}}
          </span>
        {{/each}}
      {{/if}}
    </div>
  </template>
}
