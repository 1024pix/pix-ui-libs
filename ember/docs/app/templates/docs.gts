import {DocfyLink, DocfyOutput, DocfyPreviousAndNextPage} from "@docfy/ember"

<template>
<div class='docs-layout'>
  <aside class='sidebar'>
    <DocfyOutput @scope='docs' as |node|>
      <nav>
        {{#each node.pages as |page|}}
          <DocfyLink @to={{page.url}} class='nav-link'>
            {{page.title}}
          </DocfyLink>
        {{/each}}
      </nav>
    </DocfyOutput>
  </aside>

  <main class='content'>
    {{outlet}}

    <DocfyPreviousAndNextPage as |previous next|>
      <div class='page-nav'>
        {{#if previous}}
          <DocfyLink @to={{previous.url}} class='prev-link'>
            ←
            {{previous.title}}
          </DocfyLink>
        {{/if}}
        {{#if next}}
          <DocfyLink @to={{next.url}} class='next-link'>
            {{next.title}}
            →
          </DocfyLink>
        {{/if}}
      </div>
    </DocfyPreviousAndNextPage>
  </main>
</div>
</template>
