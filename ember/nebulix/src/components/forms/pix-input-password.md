---
title: PixInputPassword
---

# PixInputPassword

`PixInputPassword` recueille un mot de passe. Il masque la saisie par défaut et
ajoute un bouton qui permet de l'afficher.

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

`@validationStatus` et `@errorMessage` fonctionnent comme sur `PixInput`.

```gjs live nebulix
import { PixInputPassword } from '@1024pix/nebulix-ember';

<template>
  <div class="demo">
    <PixInputPassword
      @id="mdp-erreur"
      @validationStatus="error"
      @errorMessage="Votre mot de passe doit contenir au moins 8 caractères, dont un chiffre."
    >
      <:label>Mot de passe en erreur</:label>
    </PixInputPassword>

    <PixInputPassword @id="mdp-success" @validationStatus="success">
      <:label>Mot de passe succès</:label>
    </PixInputPassword>
  </div>

  <style>
    .demo {
      display: flex;
      flex-direction: column;
      gap: 1rem;
      width: 400px;
    }
  </style>
</template>
```

## Champ obligatoire

`@requiredLabel` marque le champ d'un astérisque et pose l'attribut `required`.
Le texte fourni devient l'infobulle de l'astérisque.

```gjs live nebulix
import { PixInputPassword } from '@1024pix/nebulix-ember';

<template>
  <PixInputPassword @id="mdp-mandatory" @requiredLabel="Champs obligatoire">
    <:label>Mot de passe</:label>
  </PixInputPassword>
</template>
```

## Préfixe

`@prefix` affiche un texte fixe avant la saisie, à l'intérieur de la bordure. Il
sert à rappeler une partie invariable de la valeur.

```gjs live nebulix
import { PixInputPassword } from '@1024pix/nebulix-ember';

<template>
  <PixInputPassword @id="mdp-prefix" @prefix="AAA-">
    <:label>Mot de passe</:label>
  </PixInputPassword>
</template>
```

## Sous-label

`@subLabel` affiche une information supplémentaire sous le label principal.

```gjs live nebulix
import { PixInputPassword } from '@1024pix/nebulix-ember';

<template>
  <PixInputPassword @id="mdp-prefix" @subLabel="Utilisez au moins 8 caractères">
    <:label>Mot de passe</:label>
  </PixInputPassword>
</template>
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-input-password'
  @name='PixInputPasswordSignature'
/>
```
