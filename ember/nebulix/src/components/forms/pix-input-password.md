---
title: PixInputPassword
---

# PixInputPassword

`PixInputPassword` recueille un mot de passe. Il masque la saisie par défaut et
ajoute un bouton qui permet de l'afficher : c'est une aide à la saisie
attendue, ne la retirez pas.

## Utilisation

```gjs live preview nebulix
import { PixInputPassword } from '@1024pix/nebulix-ember';

<template>
  <PixInputPassword @id="mot-de-passe" autocomplete="current-password">
    <:label>Mot de passe</:label>
  </PixInputPassword>
</template>
```

Le libellé est toujours rendu : renseignez le bloc `:label`, quitte à le masquer
visuellement avec `@screenReaderOnly`.

## Validation

`@validationStatus` et `@errorMessage` fonctionnent comme sur `PixInput`. Pour un
mot de passe, le message d'erreur doit rappeler la règle non respectée sans
jamais répéter la saisie.

```gjs live nebulix
import { PixInputPassword } from '@1024pix/nebulix-ember';

<template>
  <PixInputPassword
    @id="mdp-erreur"
    @validationStatus="error"
    @errorMessage="Votre mot de passe doit contenir au moins 8 caractères, dont un chiffre."
  >
    <:label>Nouveau mot de passe</:label>
  </PixInputPassword>
</template>
```

## Préfixe

`@prefix` affiche un texte fixe avant la saisie, à l'intérieur de la bordure. Il
sert à rappeler une partie invariable de la valeur.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-input-password'
  @name='PixInputPasswordSignature'
/>
```
