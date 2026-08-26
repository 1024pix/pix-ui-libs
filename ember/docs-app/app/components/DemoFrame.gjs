// Frame around a live demo: the scoping root Nebulix's stylesheet is bound to.
// See `app/styles/demo.scss` and the `scope-nebulix` plugin in vite.config.mjs.
<template>
  <div class="nebulix">
    {{yield}}
  </div>
</template>
