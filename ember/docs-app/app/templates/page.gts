import { Page } from 'kolay/components';
import { PageNav } from 'kolay/components';

import { humanize, labelFor } from 'docs-app/utils/humanize';

import type { Page as KolayPage } from 'kolay';

<template>
  <aside>
    <PageNav>
      <:page as |p|>
        <p.Link>
          {{labelFor p.page}}
          {{#if (isNew p.page)}}<span class="nav-pill">New</span>{{/if}}
        </p.Link>
      </:page>

      <:section as |s|>
        {{#if s.index}}
          <s.index.Link>{{humanize s.section.name}}</s.index.Link>
        {{else}}
          {{humanize s.section.name}}
        {{/if}}
      </:section>
    </PageNav>
  </aside>

  <main>
    <Page>
      <:pending>Loading…</:pending>
      <:error as |error|><pre>{{reasonFor error}}</pre></:error>
      <:success as |Prose|><Prose /></:success>
    </Page>
  </main>
</template>

function isNew(page: KolayPage): boolean {
  return page.meta?.['new'] === true;
}

function reasonFor(
  error: string | { reason: string; original: Error },
): string {
  return typeof error === 'string' ? error : error.reason;
}
