import { currentURL, visit, waitFor } from '@ember/test-helpers';
import { setupApplicationTest } from 'ember-qunit';
import { module, test } from 'qunit';

module('Application | docs pages', function (hooks) {
  setupApplicationTest(hooks);

  test('a docs page renders its compiled markdown', async function (assert) {
    await visit('/nebulix/getting-started.md');

    await waitFor('h1');

    assert.dom('h1').hasText('Nebulix');
  });

  test('/ redirects to the first page of the nebulix group', async function (assert) {
    await visit('/');

    assert.strictEqual(currentURL(), '/nebulix/getting-started.md');

    await waitFor('h1');

    assert.dom('h1').hasText('Nebulix');
  });
});
