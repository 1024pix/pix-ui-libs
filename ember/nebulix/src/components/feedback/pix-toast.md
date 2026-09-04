---
title: PixToast
---

# PixToast

Pour afficher des notifications à l'utilisateur, il faut dabord ajouter à l'application
le composant `<PixToastContainer @closeButtonAriaLabel="Fermer la notification"/>`

`@closeButtonAriaLabel` contient le libéllé traduit du bouton icône qui permet de fermer la notification

Il faut ensuite utiliser les methodes mise à disposition par le service `pixToast`.

> On n'utilise pas le composant `<PixToast /> directement.

## Utilisation

```gjs live preview nebulix
import { PixButton, PixToastContainer } from '@1024pix/nebulix-ember';
import { service } from '@ember/service';
import Component from '@glimmer/component';

export default class ToastDemo extends Component {
  @service pixToast;

  enregistrer = () => {
    this.pixToast.sendSuccessNotification({ message: 'Vos modifications ont été enregistrées' });
  };

  <template>
    <PixButton @triggerAction={{this.enregistrer}}>Enregistrer</PixButton>

    <PixToastContainer @closeButtonAriaLabel="Fermer la notification" />
  </template>
}
```

## Les quatre type de notification

Le service `pixToast` permet d'nvoyer 4 types de notification.

| Méthode                       |
| ----------------------------- |
| `sendSuccessNotification`     |
| `sendErrorNotification`       |
| `sendInformationNotification` |
| `sendWarningNotification`     |

```gjs live nebulix
import { PixButton, PixToastContainer } from '@1024pix/nebulix-ember';
import { service } from '@ember/service';
import Component from '@glimmer/component';

export default class ToastTypesDemo extends Component {
  @service pixToast;

  succes = () => {
    this.pixToast.sendSuccessNotification({ message: "L'élève a été ajouté à la campagne" });
  };

  erreur = () => {
    this.pixToast.sendErrorNotification({ message: "L'import a échoué : le fichier est vide" });
  };

  information = () => {
    this.pixToast.sendInformationNotification({ message: 'Une nouvelle version est disponible' });
  };

  avertissement = () => {
    this.pixToast.sendWarningNotification({ message: "Trois élèves n'ont pas pu être importés" });
  };

  <template>
    <div class="demo-toasts">
      <PixButton @triggerAction={{this.succes}} @size="small">Succès</PixButton>
      <PixButton @triggerAction={{this.erreur}} @variant="error" @size="small">Erreur</PixButton>
      <PixButton @triggerAction={{this.information}} @variant="secondary" @size="small">
        Information
      </PixButton>
      <PixButton @triggerAction={{this.avertissement}} @variant="tertiary" @size="small">
        Avertissement
      </PixButton>
    </div>

    <PixToastContainer @closeButtonAriaLabel="Fermer la notification" />

    <style>
      .demo-toasts {
        display: flex;
        flex-wrap: wrap;
        gap: 0.75rem;
      }
    </style>
  </template>
}
```

> **Attention**
> Envoyer deux fois le même message et le même type ne crée pas deux
> notifications : la première est retirée puis réaffichée.

## Vider toute les notifications

Le service `pixToast` expose la mthode `removeAllNotifications` pour effacer
les notifications (à utiliser lors d'un changement de page).

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/feedback/pix-toast-container'
  @name='PixToastContainerSignature'
/>
```
