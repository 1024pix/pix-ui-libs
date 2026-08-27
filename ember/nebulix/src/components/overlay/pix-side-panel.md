---
title: PixSidePanel
---

# PixSidePanel

`PixSidePanel` ouvre un panneau sur le côté de l'écran pour afficher un détail
ou recueillir une saisie, sans quitter la page.

Préférez-le à `PixModal` dès que le contenu dépasse une question fermée : le
détail d'une ligne, un formulaire de plusieurs champs, des filtres avancés.

## Utilisation

```gjs live preview nebulix
import { PixButton, PixSidePanel } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class SidePanelDemo extends Component {
  @tracked estOuvert = false;

  basculer = () => {
    this.estOuvert = !this.estOuvert;
  };

  <template>
    <PixButton @variant="secondary" @triggerAction={{this.basculer}}>
      Voir le détail
    </PixButton>

    <PixSidePanel
      @title="Marie Dupont"
      @subtitle="Collège Jean Moulin"
      @iconName="userCircle"
      @showSidePanel={{this.estOuvert}}
      @onClose={{this.basculer}}
    >
      <:content>
        <p>Parcours commencé le 4 mars 2024.</p>
        <p>Six compétences évaluées sur seize.</p>
      </:content>
      <:footer>
        <PixButton @triggerAction={{this.basculer}}>Fermer</PixButton>
      </:footer>
    </PixSidePanel>
  </template>
}
```

`@title` est **obligatoire** : sans lui, le composant lève une erreur. Il
intitule le panneau pour les lecteurs d'écran — nommez-y ce qui est affiché,
pas l'action qui a ouvert le panneau.

`@onClose` est appelée pour toute demande de fermeture : bouton, clic sur le
fond, touche Échap.

Attention : bien qu'il laisse la page visible, le panneau la rend inaccessible
tant qu'il est ouvert. Si l'utilisateur doit consulter la page en même temps,
c'est la page elle-même qu'il faut faire évoluer.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/overlay/pix-side-panel'
  @name='PixSidePanelSignature'
/>
```
