<script setup lang="ts">
import { computed } from 'vue';

import { data } from './api.data';

const props = defineProps<{
  /** Component name, as exported by `@1024pix/nebulix-vue` (e.g. `PixButton`). */
  component: string;
}>();

const componentProps = computed(() => data[props.component]?.props ?? []);

/** Props are written in camelCase in TypeScript, but in kebab-case in templates. */
function kebabCase(name: string) {
  return name.replace(/[A-Z]/g, (letter) => `-${letter.toLowerCase()}`);
}

function escapeHtml(text: string) {
  return text.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
}

/** JSDoc descriptions use Markdown backticks for code. */
function formatDescription(description: string) {
  return escapeHtml(description).replace(/`([^`]+)`/g, '<code>$1</code>');
}
</script>

<template>
  <p v-if="componentProps.length === 0">
    Aucune propriété documentée pour <code>{{ component }}</code>.
  </p>
  <table v-else>
    <thead>
      <tr>
        <th>Propriété</th>
        <th>Type</th>
        <th>Défaut</th>
        <th>Description</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="prop in componentProps" :key="prop.name">
        <td>
          <code>{{ kebabCase(prop.name) }}</code>
          <span v-if="prop.required" title="Obligatoire">*</span>
        </td>
        <td>
          <code>{{ prop.type }}</code>
        </td>
        <td>
          <code v-if="prop.default">{{ prop.default }}</code>
        </td>
        <!-- eslint-disable-next-line vue/no-v-html -- escaped by formatDescription -->
        <td v-html="formatDescription(prop.description)"></td>
      </tr>
    </tbody>
  </table>
</template>
