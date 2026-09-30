---
"@1024pix/ember-testing-library": major
---

Le package `@1024pix/ember-testing-library` est dorénavant maintenu dans le monorepo `pix-ui-libs`.

Plusieurs Breaking changes ont été intégré dans cette migration :

- `@1024pix/ember-testing-library` a maintenant pour peer dependencies : `@testing-library/dom` et `@ember/test-helpers`.
- La librarie ne ré-exporte plus les fonctions de `@testing-library/dom` par défaut.

Pour installer la dernière version :

```sh
npm install -D @1024pix/ember-testing-library @testing-library/dom @ember/test-helpers
```
