---
title: PixStructureSwitcher
---

# PixStructureSwitcher

`PixStructureSwitcher` permet de changer de structure de rattachement — un
établissement, une organisation — sans quitter la page.

Il ne s'adresse qu'aux utilisateurs rattachés à plusieurs structures. Pour les
autres, n'affichez rien plutôt qu'un sélecteur à une seule entrée.

## Utilisation

```gjs live preview nebulix
import { PixStructureSwitcher } from '@1024pix/nebulix-ember';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

const structures = [
  { value: '1', label: 'Collège Jean Moulin' },
  { value: '2', label: 'Lycée Victor Hugo' },
  { value: '3', label: 'Collège Simone Veil' },
];

export default class SwitcherDemo extends Component {
  @tracked value = '1';

  onChange = (structure) => {
    this.value = structure.value;
  };

  get label() {
    return structures.find((structure) => structure.value === this.value).label;
  }

  <template>
    <PixStructureSwitcher
      @structures={{structures}}
      @value={{this.value}}
      @label={{this.label}}
      @onChange={{this.onChange}}
    />
  </template>
}
```

`@label` est le texte du bouton : affichez-y le nom de la structure courante,
pas une invitation générique. L'utilisateur doit savoir où il se trouve avant
d'ouvrir le menu.

`@onChange` reçoit la structure choisie en entier, pas seulement sa valeur.
C'est à vous de recharger les données de la page.

Changer de structure change tout le contexte de l'application : si des
modifications sont en cours, prévenez avant de basculer.

## API Docs

```hbs live
<ComponentSignature
  @package='@1024pix/nebulix-ember'
  @module='declarations/components/navigation/pix-structure-switcher'
  @name='PixStructureSwitcherSignature'
/>
```
