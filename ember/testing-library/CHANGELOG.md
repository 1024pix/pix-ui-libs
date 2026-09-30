# @1024pix/ember-testing-library

## 4.0.1

### Patch Changes

- [#111](https://github.com/1024pix/pix-ui-libs/pull/111) [`9a70ddc`](https://github.com/1024pix/pix-ui-libs/commit/9a70ddc606a3f80419f6e65d7e9c4e5231e67427) - Missing repository.url in package.json for publication

## 4.0.0

### Major Changes

- [#45](https://github.com/1024pix/pix-ui-libs/pull/45) [`5471911`](https://github.com/1024pix/pix-ui-libs/commit/54719112594f4488d126d85dc53c4bca3627823f) - Le package `@1024pix/ember-testing-library` est dorénavant maintenu dans le monorepo `pix-ui-libs`.
  
  Plusieurs Breaking changes ont été intégré dans cette migration :
  
  - `@1024pix/ember-testing-library` a maintenant pour peer dependencies : `@testing-library/dom` et `@ember/test-helpers`.
  - La librarie ne ré-exporte plus les fonctions de `@testing-library/dom` par défaut.
  
  Pour installer la dernière version :
  
  ```sh
  npm install -D @1024pix/ember-testing-library @testing-library/dom @ember/test-helpers
  ```
