import { pageTitle } from 'ember-page-title';
import { GroupNav } from 'kolay/components';

<template>
  {{pageTitle "Pix UI Libs"}}

  <div class="app-layout">
    <header>
      <GroupNav />
    </header>

    {{outlet}}

    <footer>
      <p>Pix UI Libs</p>
    </footer>
  </div>
</template>
