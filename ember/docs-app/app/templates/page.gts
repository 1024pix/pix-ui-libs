import { Page } from 'kolay/components';
import { PageNav } from 'kolay/components';

function reasonFor(
  error: string | { reason: string; original: Error },
): string {
  return typeof error === 'string' ? error : error.reason;
}

<template>
  <aside>
    (side nav)
    <PageNav />
  </aside>

  <main>
    (main content)
    <Page>
      <:pending>Loading…</:pending>
      <:error as |error|><pre>{{reasonFor error}}</pre></:error>
      <:success as |Prose|><Prose /></:success>
    </Page>
  </main>
</template>
