---
title: Tester un composant
---

# Tester un composant

## Lancer les tests

Pendant le développement, depuis la racine du dépôt :

```bash
pnpm dev
```

Les tests sont servis sur [http://localhost:4200/tests](http://localhost:4200/tests).

Pour exécuter les tests en headless dans le terminal (comme dans la CI) :

```bash
pnpm test
```

## Écrire un test

Le test d'un composant vit dans `ember/test-app/tests`, sous la même rubrique que le composant :

```sh
ember/nebulix/src/components/layout/pix-block.gjs                       # le composant dans "nebulix"
ember/test-app/tests/integration/components/layout/pix-block-test.gjs   # le test dans "test-app"
```

C'est l'API publique de `@1024pix/nebulix-ember` qui est testée. Il faut donc toujours exporter le composant dans `nebulix/src/index.js` pour qu'il soit accessible dans les tests.

Le squelette d'un test :

```gjs
import { render } from '@1024pix/ember-testing-library';
import { PixMonComposant } from '@1024pix/nebulix-ember';
import { setupRenderingTest } from 'ember-qunit';
import { module, test } from 'qunit';

module('Integration | Component | PixMonComposant', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders the label', async function (assert) {
    // when
    const screen = await render(<template><PixMonComposant @label="Enregistrer" /></template>);

    // then
    assert.dom(screen.getByText('Enregistrer')).exists();
  });
});
```

## Linter et formatter

```bash
pnpm lint
pnpm lint:fix
```

`pnpm lint` passe sur tous les paquets et enchaîne quatre vérifications : le formatage (`prettier`), le JavaScript (`eslint`), les templates (`ember-template-lint`) et les types (`ember-tsc`).

`pnpm lint:fix` corrige les trois premières. **Les erreurs de types ne sont jamais corrigées automatiquement**, il faut les traiter à la main.

## Problèmes

**`pnpm test` produit des erreurs en locale mais pas dans la CI**:

- S'assurer d'avoir une version à jour de Google Chrome ou Firefox pour l'exécution des tests en headless.
- Supprimer les fichiers temporaires `embroider/vite` avec `rm -rf "$TMPDIR"/embroider-vite-jump-*`.
