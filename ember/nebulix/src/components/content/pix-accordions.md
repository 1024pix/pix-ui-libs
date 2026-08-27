---
title: PixAccordions
---

# PixAccordions

`PixAccordions` masque un contenu secondaire derrière un titre cliquable. Il
allège une page longue en laissant l'utilisateur n'ouvrir que ce qui
l'intéresse.

Ne l'utilisez pas pour du contenu que tout le monde doit lire : ce qui est
replié est très majoritairement ignoré. Une aide contextuelle, une liste de
questions fréquentes, le détail d'un résultat s'y prêtent ; une consigne, non.

## Utilisation

```gjs live preview nebulix
import { PixAccordions } from '@1024pix/nebulix-ember';

<template>
  <PixAccordions>
    <:title>Comment sont calculés mes résultats ?</:title>
    <:content>
      Votre score évolue à chaque test : chaque bonne réponse renforce le niveau estimé, chaque
      erreur l'ajuste à la baisse.
    </:content>
  </PixAccordions>
</template>
```

Les deux blocs sont attendus. Le titre est rendu dans un bouton : formulez-le
comme la question à laquelle le contenu répond, pour que l'utilisateur sache ce
qu'il ouvre.

Le contenu n'est rendu qu'au premier dépliage, et le composant s'ouvre replié.

## Titre enrichi

`@iconName` place une icône avant le titre. `@tagContent` et `@tagColor`
affichent une étiquette à droite, utile pour signaler un état — nouveau,
obligatoire, terminé.

```gjs live nebulix
import { PixAccordions } from '@1024pix/nebulix-ember';

<template>
  <PixAccordions @iconName="bell" @tagContent="Nouveau" @tagColor="green-light">
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
  <PixAccordions>
    <:title>Puis-je repasser un test ?</:title>
    <:content>Oui, après un délai de sept jours.</:content>
  </PixAccordions>

  <PixAccordions>
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
