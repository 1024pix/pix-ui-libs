---
title: PixModal
---

# PixModal

`PixModal` interrompt l'utilisateur pour obtenir une décision ou une
confirmation avant de poursuivre. Tant qu'elle est ouverte, le reste de la page
est inaccessible.

C'est précisément ce qui la rend coûteuse : n'y recourez que pour une action
dont les conséquences justifient l'interruption — une suppression, une
confirmation irréversible. Pour un formulaire long ou un complément
d'information, `PixSidePanel` laisse la page visible.

## Utilisation

```gjs live preview nebulix
import { PixButton, PixModal } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class ModalDemo extends Component {
  @tracked estOuverte = false;

  basculer = () => {
    this.estOuverte = !this.estOuverte;
  };

  <template>
    <PixButton @variant="error" @triggerAction={{this.basculer}}>
      Supprimer la campagne
    </PixButton>

    <PixModal
      @title="Supprimer la campagne ?"
      @subtitle="Compétences numériques 2024"
      @showModal={{this.estOuverte}}
      @onCloseButtonClick={{this.basculer}}
    >
      <:content>
        Les résultats des 138 participants seront définitivement perdus.
      </:content>
      <:footer>
        <PixButton @variant="secondary" @triggerAction={{this.basculer}}>Annuler</PixButton>
        <PixButton @variant="error" @triggerAction={{this.basculer}}>Supprimer</PixButton>
      </:footer>
    </PixModal>
  </template>
}
```

`@title` est **obligatoire** : sans lui, le composant lève une erreur. Il sert
aussi d'intitulé de la modale pour les lecteurs d'écran. Posez-y la question à
laquelle l'utilisateur doit répondre.

`@onCloseButtonClick` est appelée pour **toute** demande de fermeture : le
bouton de fermeture, un clic sur le fond, la touche Échap. Sans elle, la modale
ne peut plus être refermée.

## Écrire une modale

Le titre pose la question, `:content` en donne les conséquences, `:footer`
propose les issues.

Nommez les boutons par l'action qu'ils déclenchent — « Supprimer » plutôt que
« Confirmer ». Placez l'action de retrait à droite, l'échappatoire à sa gauche,
et donnez à l'action destructrice la variante `error`.

Une modale doit toujours offrir une sortie sans conséquence.

## Accessibilité

Le composant s'appuie sur l'élément natif `<dialog>` : le focus est déplacé
dans la modale à l'ouverture, retenu à l'intérieur tant qu'elle est ouverte, et
rendu à la fermeture à l'élément qui l'avait ouverte. `@focusOnClose` permet de
désigner un autre élément, par exemple lorsque le déclencheur a disparu entre
temps.

Le titre est rendu dans un `<h1>` et rattaché à la modale : il est annoncé dès
l'ouverture.

## Variantes

`@variant` accorde l'en-tête aux couleurs de l'application : `default`, `orga`
ou `certif`. `@iconName` ajoute une icône à gauche du titre.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/overlay/pix-modal'
  @name='PixModalSignature'
/>
```
