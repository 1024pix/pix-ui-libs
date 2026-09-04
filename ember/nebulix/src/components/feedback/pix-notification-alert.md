---
title: PixNotificationAlert
---

# PixNotificationAlert

`PixNotificationAlert` affiche une bandeau d'information avec une icône facultative.

## Utilisation

```gjs live preview nebulix
import { PixNotificationAlert } from '@1024pix/nebulix-ember';

<template>
  <PixNotificationAlert @type="info">
    Les résultats sont mis à jour toutes les nuits.
  </PixNotificationAlert>
</template>
```

Le message est rendu dans un `<p>` : gardez-le à une ou deux phrases.

`@withIcon` ajoute l'icône correspondant au type. Elle est décorative — le
texte doit rester compréhensible sans elle.

## Types

```gjs live nebulix
import { PixNotificationAlert, PixCheckbox } from '@1024pix/nebulix-ember';

import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
export default class BannerDemo extends Component {
  @tracked
  withIcon = false;

  toggleIcon = () => {
    this.withIcon = !this.withIcon;
  };

  <template>
    <div class="demo-alerts">
      <p>
        <PixCheckbox @size="small" @checked={{this.withIcon}} {{on "change" this.toggleIcon}}>
          <:label>Afficher les icones</:label>
        </PixCheckbox>
      </p>
      <PixNotificationAlert @type="info" @withIcon={{this.withIcon}}>
        Les résultats sont mis à jour toutes les nuits.
      </PixNotificationAlert>

      <PixNotificationAlert @type="success" @withIcon={{this.withIcon}}>
        Les seize élèves ont été importés.
      </PixNotificationAlert>

      <PixNotificationAlert @type="warning" @withIcon={{this.withIcon}}>
        Trois élèves n'ont pas d'adresse e-mail : ils ne recevront pas l'invitation.
      </PixNotificationAlert>

      <PixNotificationAlert @type="error" @withIcon={{this.withIcon}}>
        L'import a échoué : le fichier ne contient aucune ligne.
      </PixNotificationAlert>

      <PixNotificationAlert @type="communication" @withIcon={{this.withIcon}}>
        L'import a échoué : le fichier ne contient aucune ligne.
      </PixNotificationAlert>

      <PixNotificationAlert @type="communication-orga" @withIcon={{this.withIcon}}>
        L'import a échoué : le fichier ne contient aucune ligne.
      </PixNotificationAlert>

      <PixNotificationAlert @type="communication-certif" @withIcon={{this.withIcon}}>
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
}
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/feedback/pix-notification-alert'
  @name='PixNotificationAlertSignature'
/>
```
