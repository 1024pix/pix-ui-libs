---
title: Ombres
---

# Ombres

Les ombres du design system sont exposées sous forme de variables CSS, définies dans `styles/pix-design-tokens/_shadows.scss`.

Chaque ombre existe aussi en classe utilitaire `.pix-shadow-md`. Les placeholder SCSS `%pix-shadow-md` sont **dépréciés**.

## Élévation

Cinq niveaux, du plus discret au plus marqué.

| Token             | Décalage | Flou |
| ----------------- | -------- | ---- |
| `--pix-shadow-xs` | 4px      | 8px  |
| `--pix-shadow-sm` | 6px      | 12px |
| `--pix-shadow-md` | 8px      | 16px |
| `--pix-shadow-lg` | 10px     | 20px |
| `--pix-shadow-xl` | 12px     | 24px |

```css
.ma-carte {
  box-shadow: var(--pix-shadow-md);
}
```

```gjs live nebulix
import { array } from '@ember/helper';
import ShadowGallery from 'docs-app/components/ShadowGallery';

<template>
  <ShadowGallery @prefix="--pix-shadow-" @names={{array "xs" "sm" "md" "lg" "xl"}} />
</template>
```

## Ombres interactives

Quatre thèmes colorés, chacun en trois états. Le nom se compose du thème, puis de l'état : `--pix-shadow-orga-hover`.

| Thème      | Repos                  | Survol                       | Pressé                         |
| ---------- | ---------------------- | ---------------------------- | ------------------------------ |
| Pix App    | `--pix-shadow-default` | `--pix-shadow-default-hover` | `--pix-shadow-default-pressed` |
| Neutre     | `--pix-shadow-neutral` | `--pix-shadow-neutral-hover` | `--pix-shadow-neutral-pressed` |
| Pix Orga   | `--pix-shadow-orga`    | `--pix-shadow-orga-hover`    | `--pix-shadow-orga-pressed`    |
| Pix Certif | `--pix-shadow-certif`  | `--pix-shadow-certif-hover`  | `--pix-shadow-certif-pressed`  |

```css
.ma-carte {
  box-shadow: var(--pix-shadow-default);
}

.ma-carte:hover {
  box-shadow: var(--pix-shadow-default-hover);
}

.ma-carte:active {
  box-shadow: var(--pix-shadow-default-pressed);
}
```

```gjs live nebulix
import { array } from '@ember/helper';
import ShadowGallery from 'docs-app/components/ShadowGallery';

<template>
  <ShadowGallery
    @title="Pix App"
    @prefix="--pix-shadow-"
    @names={{array "default" "default-hover" "default-pressed"}}
  />
  <ShadowGallery
    @title="Neutre"
    @prefix="--pix-shadow-"
    @names={{array "neutral" "neutral-hover" "neutral-pressed"}}
  />
  <ShadowGallery
    @title="Pix Orga"
    @prefix="--pix-shadow-"
    @names={{array "orga" "orga-hover" "orga-pressed"}}
  />
  <ShadowGallery
    @title="Pix Certif"
    @prefix="--pix-shadow-"
    @names={{array "certif" "certif-hover" "certif-pressed"}}
  />
</template>
```
