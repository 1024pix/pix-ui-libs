# Mise en place de Storybook pour documenter nebulix-ember

## Contexte

L'objectif est de documenter les composants de l'addon Ember v2 `@1024pix/nebulix-ember` (situé dans `ember/nebulix/`) dans une app dédiée `ember/documentation-app/`.

Le monorepo est géré par **pnpm workspaces** (`ember/*`).

---

## Pourquoi Storybook ne fonctionne pas nativement avec Ember

### Le problème de compilation

Les composants nebulix sont écrits en `.gjs` (Glimmer JS, syntaxe `<template>...</template>`). Ce n'est pas du JavaScript standard — il faut les compiler via Babel + `babel-plugin-ember-template-compilation`.

**Ce problème est résolu par le build de l'addon v2.** Rollup compile les `.gjs` en JS standard dans `dist/`. C'est identique à ce que font React (`.jsx`) ou Vue (`.vue`).

### Le problème de runtime

C'est là que Ember diffère de React/Vue.

Un composant React compilé est **autonome** : c'est une fonction JS, `ReactDOM.render()` suffit.

Un composant Ember compilé, même en `dist/`, **attend un runtime Ember actif** :

```
dist/components/actions/pix-button.js
  → importe @glimmer/tracking   (réactivité)
  → importe @ember/object        (actions)
  → importe @ember/modifier      (modifiers)
```

Ces packages supposent qu'une **application Ember a été démarrée** et a initialisé leur contexte interne. Sans ça, le rendu échoue silencieusement ou plante.

| | React | Ember |
|---|---|---|
| Build nécessaire | oui | oui (résolu par l'addon v2) |
| Runtime nécessaire | non — `ReactDOM.render()` suffit | oui — une app Ember doit être démarrée |
| Storybook sait faire | oui (officiellement) | non (pas de support officiel v7/v8) |

> `@storybook/ember` existait jusqu'à Storybook 6 mais n'a jamais été porté officiellement sur Storybook 7/8.

---

## La solution retenue

### Architecture choisie : Option B — package séparé

```
ember/
├── nebulix/              ← addon v2, inchangé
└── documentation-app/    ← app Ember + Storybook par-dessus
```

`documentation-app` est une **vraie app Ember** (comme `test-app`), avec Storybook ajouté dessus. L'app Ember fournit le runtime, Storybook fournit l'UI de documentation.

### Pourquoi pas `@storybook/html-vite` seul ?

`@storybook/html-vite` permet de rendre du HTML statique ou des Web Components. Pour un composant simple comme `PixBlock` (qui n'est qu'un `<div>` avec des classes CSS), on pourrait rendre l'HTML équivalent à la main — mais c'est un contournement, pas une vraie solution.

Pour `PixButton` par exemple :
- `@tracked isTriggering` → réactivité Glimmer
- `@action triggerAction` → système d'actions Ember
- `{{on "click" ...}}` → modifier Ember
- `PixButtonContent`, `PixButtonBase` → sous-composants Glimmer

Sans runtime Ember, rien de ça ne fonctionne.

### Comment ça s'articule

```
documentation-app/
├── app/                        ← app Ember (fournit le runtime)
│   ├── app.ts                  ← démarre l'Application Ember
│   └── router.ts
├── config/
│   └── environment.js          ← modulePrefix: 'documentation-app'
├── .storybook/
│   ├── main.js                 ← Storybook + plugins @embroider/vite dans viteFinal
│   └── preview.js              ← setApplication() démarre le runtime Ember
├── stories/                    ← les stories à créer
└── vite.config.mjs             ← identique à test-app (@embroider/vite plugins)
```

**`vite.config.mjs`** — plugins `@embroider/vite` qui compilent ET initialisent le runtime :
```js
import { classicEmberSupport, ember, extensions } from '@embroider/vite';
import { babel } from '@rollup/plugin-babel';
```

**`.storybook/main.js`** — les mêmes plugins injectés via `viteFinal` :
```js
async viteFinal(storybookConfig) {
  const { mergeConfig } = await import('vite');
  const { classicEmberSupport, ember, extensions } = await import('@embroider/vite');
  const { babel } = await import('@rollup/plugin-babel');

  return mergeConfig(storybookConfig, {
    plugins: [
      classicEmberSupport(),
      ember(),
      babel({ babelHelpers: 'runtime', extensions }),
    ],
    css: { preprocessorOptions: { scss: { api: 'modern', loadPaths: [nebulixStyles] } } },
  });
}
```

**`.storybook/preview.js`** — bootstrap du runtime Ember avec `autoboot: false` :
```js
import Application from 'documentation-app/app';
import config from 'documentation-app/config/environment';
import { setApplication } from '@ember/test-helpers';

setApplication(Application.create({ ...config.APP, autoboot: false }));
```

> `autoboot: false` empêche l'app de se monter dans la page Storybook — chaque story gère son propre rendu.

---

## Comment écrire une story

Chaque story utilise `render` de `@ember/test-helpers` et `hbs` de `ember-cli-htmlbars` :

```js
// stories/actions/pix-button.stories.js
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

export default {
  title: 'Actions/PixButton',
  argTypes: {
    variant: {
      control: 'select',
      options: ['primary', 'secondary', 'orga', 'certif', 'admin', 'modulix'],
    },
    isLoading: { control: 'boolean' },
    isDisabled: { control: 'boolean' },
  },
};

export const Primary = {
  args: { variant: 'primary' },
  render: async (args) => {
    const container = document.createElement('div');
    document.body.appendChild(container);
    await render(hbs`<PixButton @variant={{args.variant}}>Valider</PixButton>`);
    return container;
  },
};
```

---

## État des fichiers modifiés

| Fichier | Changement |
|---|---|
| `config/environment.js` | `modulePrefix: 'documentation-app'` (était `test-app`) |
| `app/app.ts` | Import corrigé vers `documentation-app/config/environment.js` |
| `.storybook/main.js` | Framework `@storybook/html-vite` + plugins `@embroider/vite` dans `viteFinal` |
| `.storybook/preview.js` | `setApplication()` avec `autoboot: false` |
| `package.json` | Ajout de `storybook`, `@storybook/html-vite`, `@storybook/addon-essentials`, `@ember/test-helpers`, `ember-cli-htmlbars` + scripts `storybook` et `build-storybook` |

---

## Prochaines étapes

1. `pnpm install` à la racine du monorepo
2. `pnpm --filter documentation-app storybook` pour lancer
3. Créer `stories/layout/pix-block.stories.js` pour valider la chaîne complète
4. Si ça fonctionne, écrire la story `PixButton` comme exemple de composant complexe

---

## Alternatives non retenues

- **`@storybook/ember` v6** : abandonné, ne supporte pas Storybook 7/8
- **Storybook `html-vite` seul** : contournement HTML statique, ne rend pas les vrais composants Ember
- **Kolay** (`@ember-learn/kolay-ui`) : addon Ember natif pour documenter des addons, plus simple à configurer mais moins connu et moins riche que Storybook
- **Ajouter Storybook à `test-app`** : techniquement équivalent, écarté pour des raisons d'organisation