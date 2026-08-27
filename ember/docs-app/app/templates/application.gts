import DocsGroupNav from 'docs-app/components/DocsGroupNav.gts';
import { nebulixVersion } from 'docs-app/utils/build-info';
import { pageTitle } from 'ember-page-title';

<template>
  {{pageTitle "Pix UI Libs"}}

  <div class="app-layout">
    <header>
      <DocsGroupNav />
    </header>

    {{outlet}}

    <footer>
      <a href="https://github.com/1024pix/pix-ui-libs" target="_blank" rel="noopener noreferrer">
        GitHub
      </a>
      <a
        href="https://github.com/1024pix/pix-ui-libs/blob/dev/ember/nebulix/CHANGELOG.md"
        target="_blank"
        rel="noopener noreferrer"
      >
        Changelog
      </a>

      <span class="version">v{{nebulixVersion}}</span>
    </footer>
  </div>
</template>
