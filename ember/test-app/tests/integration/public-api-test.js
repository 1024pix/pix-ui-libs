import * as nebulix from '@1024pix/nebulix-ember';
import nebulixManifest from '@1024pix/nebulix-ember/package.json';
import { dasherize } from '@ember/string';
import { module, test } from 'qunit';

/**
 * Nebulix exposes each component twice, through two lists maintained
 * separately: `src/index.js` for the strict path, and the `ember-addon.app-js`
 * reexports for the classic resolver. Nothing keeps them in sync, so a
 * component present in only one of them stays invisible until an app breaks.
 *
 * The classic path cannot be probed through `owner.factoryFor`: Embroider
 * resolves app-js reexports at build time, so they never reach the runtime
 * container. Comparing the two manifests is what actually catches the drift.
 */
module('Integration | public API', function () {
  const exportedComponents = Object.keys(nebulix);
  const appJsModules = new Set(Object.keys(nebulixManifest['ember-addon']['app-js']));

  test('the package index resolves and exports components', function (assert) {
    assert.true(exportedComponents.length > 0, 'the addon built and its main entry point resolved');
  });

  for (const name of exportedComponents) {
    test(`${name} is available on both resolution paths`, function (assert) {
      assert.ok(nebulix[name], `${name} is exported from the package index`);

      const appJsModule = `./components/${dasherize(name)}.js`;
      assert.true(
        appJsModules.has(appJsModule),
        `${appJsModule} is declared in ember-addon.app-js`,
      );
    });
  }
});
