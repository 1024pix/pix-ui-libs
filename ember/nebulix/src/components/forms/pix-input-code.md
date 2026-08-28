---
title: PixInputCode
---

# PixInputCode

`PixInputCode` recueille un code caractère par caractère, une case par
caractère. Le focus avance tout seul à mesure de la saisie, et le collage
répartit le code sur l'ensemble des cases.

Réservez-le aux écrans dont la saisie du code est l'unique objet — une
vérification par e-mail, une double authentification. Au milieu d'un formulaire,
`PixCode` s'intègre mieux.

## Utilisation

```gjs live preview nebulix
import { PixInputCode } from '@1024pix/nebulix-ember';

const handleCheckCode = () => {
  // votre action
};

<template>
  <PixInputCode
    @legend="Saisissez le code reçu par e-mail"
    @ariaLabel="Chiffre du code"
    @onAllInputsFilled={{handleCheckCode}}
  />
</template>
```

`@legend` et `@ariaLabel` sont **obligatoires** : sans eux, le composant lève une
erreur. `@legend` intitule le groupe de cases ; `@ariaLabel` nomme chaque case
individuellement, complété automatiquement par son numéro (« Chiffre du code
3 »).

`@onAllInputsFilled` est appelée avec le code complet dès que toutes les cases
sont remplies.

## Nombre et nature des caractères

Par défaut, le composant attend **6 chiffres** de 1 à 9 (le zéro n'est pas accepté).

- `@numInputs` change le nombre de
  cases
- `@inputType="text"` permet d'accepter des caractères alphanumériques.

```gjs preview nebulix
import { PixInputCode } from '@1024pix/nebulix-ember';

<template>
  <PixInputCode @legend="Code à 4 chiffres" @ariaLabel="Caractère du code" @numInputs={{4}} />
</template>
```

## Accessibilité

Le composant annonce de lui-même comment naviguer entre les cases et comment les
remplir grâce à une explication par défaut en français pour chaque type: numérique et alphanumérique. Afin de gérer les traductions de ce texte il faudra le remplacer en utilisant `@explanationOfUse`.

```gjs preview nebulix
import { PixInputCode } from '@1024pix/nebulix-ember';
import { t } from 'ember-intl';

<template>
  <PixInputCode
    @legend={{t "code.legend"}}
    @ariaLabel={{t "code.aria-label"}}
    @numInputs={{4}}
    @explanationOfUse={{t "code.explanation"}}
  />
</template>
```

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-input-code'
  @name='PixInputCodeSignature'
/>
```
