---
title: PixToast
---

# PixToast

Une notification éphémère confirme qu'une action a abouti, ou signale qu'elle a
échoué. Elle apparaît par-dessus la page, sans interrompre ce que fait
l'utilisateur.

Le mécanisme tient en deux parties : `PixToastContainer`, placé **une seule
fois** dans votre application, et le service `pixToast`, que vous injectez là où
vous avez quelque chose à annoncer.

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

`@closeButtonAriaLabel` est le nom du bouton de fermeture pour les lecteurs
d'écran. Le bouton n'ayant pas de texte visible, il en est le seul intitulé.

## Les quatre notifications

| Méthode                       | Quand l'utiliser                                        |
| ----------------------------- | ------------------------------------------------------- |
| `sendSuccessNotification`     | Une action a abouti. C'est le cas le plus fréquent.     |
| `sendErrorNotification`       | Une action a échoué et l'utilisateur doit le savoir.    |
| `sendInformationNotification` | Un fait dont l'utilisateur n'est pas l'auteur.          |
| `sendWarningNotification`     | Une action a abouti, mais avec une réserve à connaître. |

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

## Écrire le message

Le message est la notification : il n'y a ni titre, ni bouton d'action.

Écrivez un constat court, au passé, qui nomme l'objet concerné —
« L'élève a été ajouté à la campagne » plutôt que « Succès ». En cas d'erreur,
donnez la cause et la suite à donner ; si la correction demande plus d'une
phrase, c'est que le message n'a pas sa place dans une notification.

Une notification n'attend aucune réponse et peut être manquée. N'y placez
jamais une information dont l'utilisateur aura besoin plus tard.

## Éviter les doublons

Envoyer deux fois le même message et le même type ne crée pas deux
notifications : la première est retirée puis réaffichée. Une action répétée ne
peut donc pas empiler les notifications identiques.

`removeAllNotifications` vide la pile, par exemple lors d'un changement de page.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/feedback/pix-toast-container'
  @name='PixToastContainerSignature'
/>
```
