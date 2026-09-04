---
title: PixAccordions
---

# PixAccordions

> Veuillez utiliser le paramètre `@isV2Version="true"` pour ce composant.
> Il permet d'avoir le nouveau style du composant comme prévue dans
> le design system.

`PixAccordions` est un élément comprenant un libellé et un contenu.
Le contenu est masqué et un clic sur le libellé permet de montrer le contenu
du `PixAccordions`.

Il est possible de cumuler les PixAccordions de sorte à former un accordéon,
il suffit de les mettre dans une même div parente.

Ce composant possède deux yield nommés :

- `:title`, destiné à accueillir le label de l'accordéon.
- `:content`, destiné à accueillir le contenu lorsque l'accordéon est déroulé.

## Utilisation

```gjs live preview nebulix
import { PixAccordions } from '@1024pix/nebulix-ember';

<template>
  <PixAccordions @isV2Version="true">
    <:title>Comment sont calculés mes résultats ?</:title>
    <:content>
      Votre score évolue à chaque test : chaque bonne réponse renforce le niveau estimé, chaque
      erreur l'ajuste à la baisse.
    </:content>
  </PixAccordions>
</template>
```

## Titre enrichi

`@iconName` (et `@plainIcon`) place une icône avant le titre. `@tagContent` et `@tagColor`
affichent une `PixTag` à droite.

```gjs live nebulix
import { PixAccordions } from '@1024pix/nebulix-ember';

<template>
  <PixAccordions @isV2Version="true" @iconName="bell" @tagContent="Nouveau" @tagColor="green-light">
    <:title>Notifications par e-mail</:title>
    <:content>
      Vous pouvez désormais choisir la fréquence des e-mails que vous recevez.
    </:content>
  </PixAccordions>
</template>
```

## Plusieurs sections

Chaque `PixAccordions` est autonome : ouvrir l'un n'en referme aucun autre.
Empilez-les simplement pour former un groupe.

```gjs live nebulix
import { PixAccordions } from '@1024pix/nebulix-ember';

<template>
  <PixAccordions @isV2Version="true">
    <:title>Puis-je repasser un test ?</:title>
    <:content>Oui, après un délai de sept jours.</:content>
  </PixAccordions>

  <PixAccordions @isV2Version="true">
    <:title>Mes résultats sont-ils visibles par mon établissement ?</:title>
    <:content>Seuls les résultats des campagnes auxquelles vous participez le sont.</:content>
  </PixAccordions>
</template>
```

`@isV2Version` applique le jeu de styles de deuxième génération, conçu pour ces
empilements : les sections y sont séparées par un filet et celle qui est
ouverte se détache par une ombre.

## Mode contrôlé

> **⚠️ Le mode non contrôlé est déprécié.** Utilisez `@isExpanded` et `@onToggle` :
> le composant avertit en développement lorsque `@onToggle` n'est pas fourni.

Historiquement, chaque `PixAccordions` gérait son état tout seul. `@isExpanded` et
`@onToggle` donnent la main au parent, ce qui est nécessaire pour piloter plusieurs
accordéons d'un coup, un bouton « tout déplier » par exemple.

Dans ce mode, le composant n'ouvre ni ne ferme plus de lui-même : il signale
l'intention de l'utilisateur via `@onToggle`, et c'est au parent de répercuter la
nouvelle valeur sur `@isExpanded`.

```gjs live preview nebulix
import { PixAccordions, PixButton } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class AccordionsDemo extends Component {
  @tracked isScoreExpanded = false;
  @tracked isRetryExpanded = false;

  get areAllExpanded() {
    return this.isScoreExpanded && this.isRetryExpanded;
  }

  toggleScore = (isExpanded) => {
    this.isScoreExpanded = isExpanded;
  };

  toggleRetry = (isExpanded) => {
    this.isRetryExpanded = isExpanded;
  };

  toggleAll = () => {
    const nextIsExpanded = !this.areAllExpanded;
    this.isScoreExpanded = nextIsExpanded;
    this.isRetryExpanded = nextIsExpanded;
  };

  <template>
    <div class="demo-controlled-accordions">
      <PixButton @triggerAction={{this.toggleAll}} @size="small" @variant="secondary">
        {{if this.areAllExpanded "Tout replier" "Tout déplier"}}
      </PixButton>
    </div>

    <PixAccordions
      @isV2Version="true"
      @isExpanded={{this.isScoreExpanded}}
      @onToggle={{this.toggleScore}}
    >
      <:title>Comment sont calculés mes résultats ?</:title>
      <:content>Chaque bonne réponse renforce le niveau estimé, chaque erreur l'ajuste à la baisse.</:content>
    </PixAccordions>

    <PixAccordions
      @isV2Version="true"
      @isExpanded={{this.isRetryExpanded}}
      @onToggle={{this.toggleRetry}}
    >
      <:title>Puis-je repasser un test ?</:title>
      <:content>Oui, après un délai de sept jours.</:content>
    </PixAccordions>

    <style>
      .demo-controlled-accordions {
        margin-bottom: 0.75rem;
      }
    </style>
  </template>
}
```

Un accordéon contrôlé déplié affiche son contenu dès le premier rendu, sans clic
préalable. C'est ce qui permet de déplier d'un seul coup des accordéons imbriqués,
y compris ceux qui n'étaient pas encore rendus.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/content/pix-accordions'
  @name='PixAccordionsSignature'
/>
```
