---
title: PixOverlay
---

# PixOverlay

`PixOverlay` est la surcouche sur laquelle reposent `PixModal` et
`PixSidePanel` : un élément `<dialog>` natif qui assombrit la page, retient le
focus et se ferme à la touche Échap.

Utilisez-la directement seulement si aucun des deux ne convient — sinon, vous
reconstruisez un en-tête, un titre et un bouton de fermeture qu'ils fournissent
déjà.

## Utilisation

```gjs live preview nebulix
import { PixButton, PixOverlay } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class OverlayDemo extends Component {
  @tracked estVisible = false;

  basculer = () => {
    this.estVisible = !this.estVisible;
  };

  <template>
    <PixButton @triggerAction={{this.basculer}}>Ouvrir la surcouche</PixButton>

    <PixOverlay
      @isVisible={{this.estVisible}}
      @onClose={{this.basculer}}
      @hasCenteredContent={{true}}
      @labelledBy="titre-surcouche"
    >
      <div class="demo-overlay-content">
        <h1 id="titre-surcouche">Contenu libre</h1>
        <PixButton @triggerAction={{this.basculer}}>Fermer</PixButton>
      </div>
    </PixOverlay>

    <style>
      .demo-overlay-content {
        display: flex;
        flex-direction: column;
        gap: 1rem;
        padding: 2rem;
        background-color: var(--pix-neutral-0);
        border-radius: 8px;
      }
    </style>
  </template>
}
```

`@onClose` est appelée pour toute demande de fermeture : clic sur le fond,
touche Échap, fermeture native. **Sans elle, l'utilisateur ne peut plus
ressortir.**

`@labelledBy` reprend l'identifiant du titre de votre contenu : c'est ce qui
donne un nom à la surcouche pour les lecteurs d'écran. `@describedBy` fait de
même pour la description.

`@hasCenteredContent` centre le contenu dans la fenêtre. Sans lui, il se place
en haut à gauche.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/overlay/pix-overlay'
  @name='PixOverlaySignature'
/>
```
