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

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/content/pix-accordions'
  @name='PixAccordionsSignature'
/>
```
