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
      <a href="https://github.com/1024pix/pix-ui-libs/blob/dev/ember/nebulix/CHANGELOG.md" target="_blank">
        Changelog
      </a>
    </footer>
  </div>
</template>
