---
title: PixSegmentedControl
---

# PixSegmentedControl

`PixSegmentedControl` bascule entre **deux** présentations d'un même contenu :
une liste ou une grille, des données brutes ou agrégées.

Le contenu reste le même, seule sa présentation change. Si le choix mène à
d'autres données, ce sont des onglets qu'il vous faut.

## Utilisation

```gjs live preview nebulix
import { PixSegmentedControl } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class SegmentedDemo extends Component {
  @tracked enSynthese = false;

  basculer = (valeur) => {
    this.enSynthese = valeur;
  };

  <template>
    <PixSegmentedControl
      @toggled={{this.enSynthese}}
      @onChange={{this.basculer}}
      @iconA="readMore"
      @iconB="monitoring"
    >
      <:label>Affichage des résultats</:label>
      <:viewA>Détail</:viewA>
      <:viewB>Synthèse</:viewB>
    </PixSegmentedControl>
  </template>
}
```

`@toggled` désigne la vue active : `false` pour `:viewA`, `true` pour `:viewB`.
`@onChange` reçoit la nouvelle valeur — c'est à vous de la conserver.

Le composant rend un groupe de boutons radio : la navigation entre les deux vues
se fait aux flèches du clavier, comme pour un choix unique.

Le bloc `:label` intitule le choix. Il est obligatoire pour les lecteurs
d'écran ; `@screenReaderOnly` permet de le masquer visuellement quand le
contexte suffit.

## Icônes

`@iconA` et `@iconB` placent une icône devant chaque vue. La vue active affiche
son icône en plein, l'autre en trait : c'est un renfort visuel du choix, pas
son seul indice.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/navigation/pix-segmented-control'
  @name='PixSegmentedControlSignature'
/>
```
