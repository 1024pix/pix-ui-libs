import { pageTitle } from 'ember-page-title';
import { GroupNav } from 'kolay/components';

<template>
  {{pageTitle "Pix UI Libs"}}

  <header>
    <p>(header)</p>
    <GroupNav />
  </header>

  {{outlet}}

  <footer>
    <p>(footer)</p>
  </footer>
</template>
