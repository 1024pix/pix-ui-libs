<script setup lang="ts">
defineSlots<{ default?(): unknown }>();
</script>

<template>
  <!-- `nebulix` is the scope root of Nebulix's styles, see `demo.scss`. -->
  <div class="demo-frame nebulix">
    <slot />
  </div>
</template>
