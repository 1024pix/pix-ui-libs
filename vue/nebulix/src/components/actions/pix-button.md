---
title: PixButton
---

<script setup>
import Icons from './demos/PixButtonIcons.vue';
import Loading from './demos/PixButtonLoading.vue';
import Usage from './demos/PixButtonUsage.vue';
import Variants from './demos/PixButtonVariants.vue';
</script>

# PixButton

`PixButton` rend un élément `<button>` natif avec un `type="button"` par défaut.

## Utilisation

<DemoFrame><Usage /></DemoFrame>

<<< ./demos/PixButtonUsage.vue

`trigger-action` est obligatoire, sauf si le bouton porte `type="submit"` : sans action, il soumet alors son formulaire.

### Chargement

Si `trigger-action` retourne une promesse, le bouton affiche un chargeur et ignore les clics jusqu'à ce qu'elle soit résolue. `is-loading` force cet état.

<DemoFrame><Loading /></DemoFrame>

<<< ./demos/PixButtonLoading.vue

### Icônes

Il est possible de rajouter une icône avant (`icon-before`) ou après (`icon-after`) le libellé, ou les deux. On peut afficher la version **pleine** de l'icône avec `plain-icon-before` ou `plain-icon-after`.

<DemoFrame><Icons /></DemoFrame>

<<< ./demos/PixButtonIcons.vue

> Accessibilité : les icônes sont masquées aux lecteurs d'écran. Si elles portent une information (ex : un bouton ⬅️ Précédent), il faut donner un `aria-label` au bouton (ex : « Retour à la page précédente »).

### Désactivé

`is-disabled` désactive le bouton sans utiliser l'attribut natif `disabled` : il reste focusable, et porte `aria-disabled="true"` pour que les lecteurs d'écran l'annoncent.

## Variantes

`variant` définit le rôle du bouton dans la page, pas seulement sa couleur. Par défaut : `primary`.

<DemoFrame><Variants /></DemoFrame>

| Variante      | Quand l'utiliser                                                                |
| ------------- | ------------------------------------------------------------------------------- |
| `primary`     | L'action principale attendue de l'utilisateur. Une seule par page.              |
| `primary-bis` | Une action principale sur un fond où `primary` manque de contraste.             |
| `secondary`   | Une action alternative, présentée à côté de l'action principale.                |
| `tertiary`    | Une action accessoire, de faible importance visuelle.                           |
| `success`     | Une action qui confirme ou valide définitivement.                               |
| `error`       | Une action **destructrice ou irréversible** : supprimer, révoquer, désinscrire. |

### Sur fond sombre

Les variantes `primary-white`, `secondary-white` et `tertiary-white` sont conçues pour les fonds sombres ou colorés. `transparent-dark` complète la série pour un bouton sans fond, dont `is-border-visible` fait apparaître la bordure.

<DemoFrame><Variants dark /></DemoFrame>

## API

<ApiTable component="PixButton" />
