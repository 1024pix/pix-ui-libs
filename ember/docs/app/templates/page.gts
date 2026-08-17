import { Page } from 'kolay/components';

function reasonFor(
  error: string | { reason: string; original: Error },
): string {
  return typeof error === 'string' ? error : error.reason;
}

<template>
  <Page>
    <:pending>Loading…</:pending>
    <:error as |error|><pre>{{reasonFor error}}</pre></:error>
    <:success as |Prose|><Prose /></:success>
  </Page>

  {{outlet}}
</template>
