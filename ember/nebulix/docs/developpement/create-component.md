---
title: Créer un composant
---

# Créer un composant

Les composants de Nebulix Ember sont créés dans le dossier `ember/nebulix/src/components`.

Ils sont structurés en trois fichiers : `.gjs`, `.scss` et `.md`.

- `my-component.gjs` : le fichier de logique du composant.
- `my-component.scss` : le fichier de styles du composant.
- `my-component.md` : le fichier de documentation du composant.

```gjs
// my-component.gjs
import Component from '@glimmer/component';

import './my-component.scss';

export default class MyComponent extends Component {
  <template>
    <div class="my-component">My component</div>
  </template>
}
```

```css
/* my-component.scss */
.my-component {
  color: var(--pix-primary-500);
}
```
