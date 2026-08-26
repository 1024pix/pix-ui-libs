---
title: PixGauge
---

# PixGauge

`PixGauge` situe un niveau atteint sur une échelle de 0 à 8, face au niveau
maximum atteignable. Elle est conçue pour les résultats de compétences Pix.

Pour une progression exprimée en pourcentage, utilisez `PixProgressBar`.

## Utilisation

```gjs live preview nebulix
import { PixGauge } from '@1024pix/nebulix-ember';

const paliers = ['Débutant', 'Indépendant', 'Avancé', 'Expert'];

<template>
  <PixGauge
    @reachedLevel={{4.2}}
    @maxLevel={{6}}
    @label="Niveau 4,2 atteint sur un maximum de 6"
    @stepLabels={{paliers}}
  />
</template>
```

`@reachedLevel` et `@maxLevel` s'expriment sur l'échelle de 0 à 8, quel que soit
le nombre de paliers affichés. `@label` est obligatoire : la jauge étant un
dessin, c'est la seule information transmise aux lecteurs d'écran.

`@stepLabels` nomme les paliers, répartis régulièrement sur toute l'échelle.

## Version compacte

`@isSmall` réduit la hauteur et masque les paliers. Utilisez-la dans une liste
ou un tableau, là où la jauge accompagne une autre information plutôt qu'elle
n'en est le sujet.

```gjs live nebulix
import { PixGauge } from '@1024pix/nebulix-ember';

<template>
  <PixGauge
    @reachedLevel={{3}}
    @maxLevel={{5}}
    @isSmall={{true}}
    @label="Niveau 3 atteint sur un maximum de 5"
  />
</template>
```

`@hideValues` masque en plus les chiffres portés sur la jauge. Ne l'employez que
si la valeur est déjà donnée à côté.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/data-display/pix-gauge'
  @name='PixGaugeSignature'
/>
```
