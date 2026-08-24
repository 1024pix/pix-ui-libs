import { pageTitle } from 'ember-page-title';
import { PageNav } from 'kolay/components';

<template>
  {{pageTitle "Docs"}}

  <PageNav />

  {{outlet}}
</template>
