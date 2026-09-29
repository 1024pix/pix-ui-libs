import { findTypeAlias, loadProject } from 'docs-app/utils/typedoc-project';
import { module, test } from 'qunit';

// TypeDoc's `ReflectionKind.TypeAlias`, mirrored from typedoc-project.ts.
const TYPE_ALIAS_KIND = 2097152;

module('Unit | Utility | typedoc-project', function () {
  module('#findTypeAlias', function () {
    test('finds a type alias by kind and name, however deeply nested', function (assert) {
      // given
      const project = {
        children: [
          {
            kind: 128,
            name: 'PixSelect',
            children: [
              {
                kind: TYPE_ALIAS_KIND,
                name: 'PixSelectTexts',
                children: [{ name: 'placeholder' }],
              },
            ],
          },
        ],
      };

      // when
      const found = findTypeAlias(project, 'PixSelectTexts');

      // then
      assert.strictEqual(found?.name, 'PixSelectTexts');
      assert.strictEqual(found?.children.length, 1);
    });

    test('searches inside plain nested objects, not just arrays', function (assert) {
      // given
      const project = {
        type: {
          declaration: {
            kind: TYPE_ALIAS_KIND,
            name: 'PixSelectTexts',
            children: [],
          },
        },
      };

      // when
      const found = findTypeAlias(project, 'PixSelectTexts');

      // then
      assert.strictEqual(found?.name, 'PixSelectTexts');
    });

    test('returns null when no node matches the name', function (assert) {
      // given
      const project = {
        children: [{ kind: TYPE_ALIAS_KIND, name: 'PixSelectTexts', children: [] }],
      };

      // when
      const found = findTypeAlias(project, 'PixButtonTexts');

      // then
      assert.strictEqual(found, null);
    });

    test('ignores a same-named node whose kind is not a type alias', function (assert) {
      // given
      const project = {
        children: [{ kind: 128, name: 'PixSelectTexts', children: [] }],
      };

      // when
      const found = findTypeAlias(project, 'PixSelectTexts');

      // then
      assert.strictEqual(found, null);
    });

    test('ignores a matching kind/name node that has no children array', function (assert) {
      // given
      const project = {
        children: [{ kind: TYPE_ALIAS_KIND, name: 'PixSelectTexts' }],
      };

      // when
      const found = findTypeAlias(project, 'PixSelectTexts');

      // then
      assert.strictEqual(found, null);
    });

    test('returns null for a non-object node instead of throwing', function (assert) {
      assert.strictEqual(findTypeAlias(null, 'PixSelectTexts'), null);
      assert.strictEqual(findTypeAlias(undefined, 'PixSelectTexts'), null);
      assert.strictEqual(findTypeAlias('a string', 'PixSelectTexts'), null);
      assert.strictEqual(findTypeAlias(42, 'PixSelectTexts'), null);
    });
  });

  module('#loadProject', function (hooks) {
    let originalFetch: typeof fetch;

    hooks.beforeEach(function () {
      originalFetch = globalThis.fetch;
    });

    hooks.afterEach(function () {
      globalThis.fetch = originalFetch;
    });

    test('fetches the project JSON at a slugified URL', async function (assert) {
      const requestedUrls: string[] = [];

      globalThis.fetch = ((url: string) => {
        requestedUrls.push(url);

        return Promise.resolve({ json: () => Promise.resolve({ ok: true }) } as Response);
      }) as typeof fetch;

      const project = await loadProject('@1024pix/nebulix-ember-fetch-test');

      assert.deepEqual(requestedUrls, ['/docs/@1024pix__nebulix-ember-fetch-test.json']);
      assert.deepEqual(project, { ok: true });
    });

    test('caches the request so a second call for the same package does not fetch again', async function (assert) {
      let fetchCount = 0;

      globalThis.fetch = () => {
        fetchCount++;

        return Promise.resolve({ json: () => Promise.resolve({ count: fetchCount }) } as Response);
      };

      const packageName = 'unique-package-for-cache-test';

      const first = await loadProject(packageName);
      const second = await loadProject(packageName);

      assert.strictEqual(fetchCount, 1);
      assert.strictEqual(first, second);
    });
  });
});
