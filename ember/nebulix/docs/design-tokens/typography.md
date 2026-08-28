---
title: Typographie
---

# Typographie

Les styles de texte du design system sont exposés sous forme de classes utilitaires, définies dans `styles/pix-design-tokens/_typography.scss`.

Un niveau de texte s'applique en posant sa classe sur l'élément. Il porte à lui seul la famille, la graisse, la taille et l'interlignage, et adapte sa taille aux différents écrans.

```html
<h1 class="pix-title-l">Vos résultats</h1>
```

## Titres

Tailles exprimées en `rem`, avec leur équivalent en pixels sur une base de `1rem = 16px`.

| Classe           | Mobile          | Tablette        | Desktop         | Interlignage |
| ---------------- | --------------- | --------------- | --------------- | ------------ |
| `.pix-title-l`   | 1.75rem (28px)  | 1.875rem (30px) | 2rem (32px)     | 1.3          |
| `.pix-title-m`   | 1.5rem (24px)   | 1.625rem (26px) | 1.75rem (28px)  | 1.3          |
| `.pix-title-s`   | 1.375rem (22px) | 1.375rem (22px) | 1.5rem (24px)   | 1.3          |
| `.pix-title-xs`  | 1.25rem (20px)  | 1.25rem (20px)  | 1.25rem (20px)  | 1.4          |
| `.pix-title-xxs` | 1.125rem (18px) | 1.125rem (18px) | 1.125rem (18px) | 1.625        |

```hbs live nebulix
<div style='display: flex; flex-direction: column; gap: 1rem'>
  <p class='pix-title-l'>Vos résultats</p>
  <p class='pix-title-m'>Compétences évaluées</p>
  <p class='pix-title-s'>Mener une recherche en ligne</p>
  <p class='pix-title-xs'>Épreuves passées</p>
  <p class='pix-title-xxs'>Détail du score</p>
</div>
```

## Sous-titres

| Classe              | Mobile          | Tablette        | Desktop         | Interlignage |
| ------------------- | --------------- | --------------- | --------------- | ------------ |
| `.pix-subtitle-l`   | 1.5rem (24px)   | 1.625rem (26px) | 1.75rem (28px)  | 1.5          |
| `.pix-subtitle-m`   | 1.25rem (20px)  | 1.375rem (22px) | 1.5rem (24px)   | 1.5          |
| `.pix-subtitle-s`   | 1.125rem (18px) | 1.125rem (18px) | 1.25rem (20px)  | 1.5          |
| `.pix-subtitle-xs`  | 1rem (16px)     | 1rem (16px)     | 1.125rem (18px) | 1.5          |
| `.pix-subtitle-xxs` | 0.875rem (14px) | 0.875rem (14px) | 1rem (16px)     | 1.5          |

```hbs live nebulix
<div style='display: flex; flex-direction: column; gap: 1rem'>
  <p class='pix-subtitle-l'>Certification du 12 mars</p>
  <p class='pix-subtitle-m'>Niveau atteint sur seize</p>
  <p class='pix-subtitle-s'>Dernière tentative</p>
  <p class='pix-subtitle-xs'>Temps restant</p>
  <p class='pix-subtitle-xxs'>Mis à jour ce matin</p>
</div>
```

## Corps de texte

| Classe         | Mobile          | Tablette        | Desktop         | Interlignage |
| -------------- | --------------- | --------------- | --------------- | ------------ |
| `.pix-body-l`  | 1rem (16px)     | 1.125rem (18px) | 1.125rem (18px) | 1.5          |
| `.pix-body-m`  | 0.875rem (14px) | 1rem (16px)     | 1rem (16px)     | 1.5          |
| `.pix-body-s`  | 0.875rem (14px) | 0.875rem (14px) | 0.875rem (14px) | 1.5          |
| `.pix-body-xs` | 0.75rem (12px)  | 0.75rem (12px)  | 0.75rem (12px)  | 1.5          |

```hbs live nebulix
<div style='display: flex; flex-direction: column; gap: 1rem'>
  <p class='pix-body-l'>Chaque épreuve mesure une compétence précise et vous situe sur une échelle
    de huit niveaux.</p>
  <p class='pix-body-m'>Chaque épreuve mesure une compétence précise et vous situe sur une échelle
    de huit niveaux.</p>
  <p class='pix-body-s'>Chaque épreuve mesure une compétence précise et vous situe sur une échelle
    de huit niveaux.</p>
  <p class='pix-body-xs'>Chaque épreuve mesure une compétence précise et vous situe sur une échelle
    de huit niveaux.</p>
</div>
```

### Texte à chasse fixe

`.pix-monospace` applique la famille Roboto Mono et la graisse `--pix-font-normal`.

```hbs live nebulix
<p class='pix-body-m pix-monospace'>--pix-font-normal</p>
```

## Familles de police

| Famille          | Usage               | Classes qui l'appliquent                                                                         |
| ---------------- | ------------------- | ------------------------------------------------------------------------------------------------ |
| Nunito           | Titres              | `.pix-title-l`, `.pix-title-m`, `.pix-title-s`, `.pix-title-xs`, `.pix-title-xxs`                |
| Roboto Condensed | Sous-titres         | `.pix-subtitle-l`, `.pix-subtitle-m`, `.pix-subtitle-s`, `.pix-subtitle-xs`, `.pix-subtitle-xxs` |
| Roboto           | Corps de texte      | `.pix-body-l`, `.pix-body-m`, `.pix-body-s`, `.pix-body-xs`                                      |
| Roboto Mono      | Texte à chasse fixe | `.pix-monospace`                                                                                 |

## Graisses

| Variable               | Valeur | Appliquée par défaut à              |
| ---------------------- | ------ | ----------------------------------- |
| `--pix-font-normal`    | 400    | Corps de texte, texte à chasse fixe |
| `--pix-font-medium`    | 500    | Sous-titres                         |
| `--pix-font-bold`      | 700    | —                                   |
| `--pix-font-extrabold` | 800    | Titres                              |

Deux classes utilitaires permettent de renforcer un texte sans changer son niveau :

| Classe                    | Graisse                   |
| ------------------------- | ------------------------- |
| `.pix-body-weight-medium` | `--pix-font-medium` (500) |
| `.pix-body-weight-bold`   | `--pix-font-bold` (700)   |
