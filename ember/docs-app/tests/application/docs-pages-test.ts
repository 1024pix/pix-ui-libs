import { currentURL, visit, waitFor } from '@ember/test-helpers';
import { setupApplicationTest } from 'ember-qunit';
import { module, test } from 'qunit';

const FIRST_NEBULIX_PAGE = '/nebulix/nebulix-ember/installation.md';

module('Application | docs pages', function (hooks) {
  setupApplicationTest(hooks);

  test('a docs page renders its compiled markdown', async function (assert) {
    await visit(FIRST_NEBULIX_PAGE);

    await waitFor('h1');

    assert.dom('h1').hasText('Installer Nebulix Ember');
  });

  test('/ redirects to the first page of the nebulix group', async function (assert) {
    await visit('/');

    assert.strictEqual(currentURL(), FIRST_NEBULIX_PAGE);

    await waitFor('h1');

    assert.dom('h1').hasText('Installer Nebulix Ember');
  });

  test('the group navigation lists the docs groups, without kolay’s Home', async function (assert) {
    await visit('/');

    assert.dom('nav[aria-label="Groups"] a').exists({ count: 2 });
    assert.dom('nav[aria-label="Groups"]').hasText('Nebulix Components');
  });
});
