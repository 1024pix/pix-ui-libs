---
title: Classes utilitaires
---

# Classes utilitaires

Nebulix expose quelques classes CSS à poser directement sur un élément. Elles sont chargées avec `nebulix-styles`, sans import supplémentaire.

## Masquer un texte à l'écran

`.screen-reader-only` retire un élément du rendu visuel sans le retirer de l'arbre d'accessibilité : le texte reste lu par les lecteurs d'écran. Elle sert à porter une information que la mise en page rend évidente à l'œil, mais que la lecture linéaire perd, par exemple.

```hbs
<button type='button'>
  <PixIcon @name='trash' @ariaHidden={{true}} />
  <span class='screen-reader-only'>Supprimer la ligne</span>
</button>
```

La classe s'appuie sur une recette décrite dans [Cache-cache CSS](https://www.ffoodd.fr/cache-cache-css/).

## Révéler au focus

`.screen-reader-only-focusable` se pose **en plus** de `.screen-reader-only` : l'élément reste masqué jusqu'à ce qu'il reçoive le focus, puis réapparaît à l'écran. C'est le comportement attendu d'un lien d'évitement, qui ne doit se montrer qu'à la navigation clavier.

```hbs
<a href='#contenu' class='screen-reader-only screen-reader-only-focusable'>
  Aller au contenu principal
</a>
```
