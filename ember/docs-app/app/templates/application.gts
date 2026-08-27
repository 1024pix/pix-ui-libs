import { pageTitle } from 'ember-page-title';
import { GroupNav } from 'kolay/components';

import { gitRef, nebulixVersion } from 'docs-app/utils/build-info';
import { humanize } from 'docs-app/utils/humanize';

<template>
  {{pageTitle "Pix UI Libs"}}

  <div class="app-layout">
    <header>
      <GroupNav as |name|>{{humanize name}}</GroupNav>
    </header>

    {{outlet}}

    <footer>
      <a
        href="https://github.com/1024pix/pix-ui-libs"
        target="_blank"
        rel="noopener noreferrer"
      >
        GitHub
      </a>
      <a
        href="https://github.com/1024pix/pix-ui-libs/blob/dev/ember/nebulix/CHANGELOG.md"
        target="_blank"
        rel="noopener noreferrer"
      >
        Changelog
      </a>

      <span class="version">v{{nebulixVersion}} ({{gitRef}})</span>
    </footer>
  </div>
</template>
