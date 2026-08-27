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

const verifier = () => {
  // votre action
};

<template>
  <PixInputCode
    @legend="Saisissez le code reçu par e-mail"
    @ariaLabel="Chiffre du code"
    @onAllInputsFilled={{verifier}}
  />
</template>
```

`@legend` et `@ariaLabel` sont **obligatoires** : sans eux, le composant lève une
erreur. `@legend` intitule le groupe de cases ; `@ariaLabel` nomme chaque case
individuellement, complété automatiquement par son numéro (« Chiffre du code
3 »).

`@onAllInputsFilled` est appelée avec le code complet dès que toutes les cases
sont remplies. Ne demandez pas de validation supplémentaire.

## Nombre et nature des caractères

Par défaut, le composant attend **6 chiffres**. `@numInputs` change le nombre de
cases, `@inputType="text"` accepte des caractères alphanumériques.

```gjs live nebulix
import { PixInputCode } from '@1024pix/nebulix-ember';

<template>
  <PixInputCode
    @legend="Saisissez le code d'accès de votre établissement"
    @ariaLabel="Caractère du code"
    @numInputs={{4}}
    @inputType="text"
  />
</template>
```

En mode `number`, seuls les chiffres de 1 à 9 sont acceptés — le zéro ne l'est
pas.

## Accessibilité

Le composant annonce de lui-même comment naviguer entre les cases et comment les
remplir. `@explanationOfUse` permet de remplacer ce texte si votre contexte
l'exige, mais ne le supprimez pas : il est la seule indication dont dispose un
utilisateur de lecteur d'écran pour comprendre ce découpage en cases.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/forms/pix-input-code'
  @name='PixInputCodeSignature'
/>
```
