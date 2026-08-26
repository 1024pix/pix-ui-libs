---
title: PixNotificationAlert
---

# PixNotificationAlert

`PixNotificationAlert` affiche un message au sein d'une page, à l'endroit exact
où il fait sens : sous un formulaire, dans une carte, au-dessus d'une liste.

C'est le message qui reste. Pour une confirmation éphémère après une action,
utilisez une notification `PixToast` ; pour une annonce en tête d'application,
`PixBannerAlert`.

## Utilisation

```gjs live preview nebulix
import { PixNotificationAlert } from '@1024pix/nebulix-ember';

<template>
  <PixNotificationAlert @type="info" @withIcon={{true}}>
    Les résultats sont mis à jour toutes les nuits.
  </PixNotificationAlert>
</template>
```

Le message est rendu dans un `<p>` : gardez-le à une ou deux phrases.

`@withIcon` ajoute l'icône correspondant au type. Elle est décorative — le
texte doit rester compréhensible sans elle.

## Types

```gjs live nebulix
import { PixNotificationAlert } from '@1024pix/nebulix-ember';

<template>
  <div class="demo-alerts">
    <PixNotificationAlert @type="info" @withIcon={{true}}>
      Les résultats sont mis à jour toutes les nuits.
    </PixNotificationAlert>

    <PixNotificationAlert @type="success" @withIcon={{true}}>
      Les seize élèves ont été importés.
    </PixNotificationAlert>

    <PixNotificationAlert @type="warning" @withIcon={{true}}>
      Trois élèves n'ont pas d'adresse e-mail : ils ne recevront pas l'invitation.
    </PixNotificationAlert>

    <PixNotificationAlert @type="error" @withIcon={{true}}>
      L'import a échoué : le fichier ne contient aucune ligne.
    </PixNotificationAlert>
  </div>

  <style>
    .demo-alerts {
      display: flex;
      flex-direction: column;
      gap: 1rem;
    }
  </style>
</template>
```

| Type      | Ce qu'il exprime                                       |
| --------- | ------------------------------------------------------ |
| `info`    | Un fait utile à connaître, sans conséquence immédiate. |
| `success` | Une opération qui s'est bien déroulée.                 |
| `warning` | Une réserve : l'action a abouti, mais pas entièrement. |
| `error`   | Un blocage que l'utilisateur doit lever.               |

Les types `communication`, `communication-orga` et `communication-certif` sont
réservés aux annonces institutionnelles.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/feedback/pix-notification-alert'
  @name='PixNotificationAlertSignature'
/>
```
