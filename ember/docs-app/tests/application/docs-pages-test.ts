import { click, currentURL, visit, waitFor } from '@ember/test-helpers';
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

  test('the page navigation links stay inside the app', async function (assert) {
    await visit(FIRST_NEBULIX_PAGE);

    const link = document.querySelector<HTMLAnchorElement>('aside a:not(.active)');
    assert.ok(link, 'the page navigation has a link to another page');

    // a full page load would leave the test app, so currentURL would not move
    await click(link!);

    assert.strictEqual(currentURL(), link!.getAttribute('href'));
  });

  test('renders a pix-button component', async function (assert) {
    await visit('/components/actions/pix-button.md');

    assert.dom('main button').hasText('Enregistrer');
  });

  test('the header shows the search trigger', async function (assert) {
    await visit('/');

    assert.dom('header .kolay__search__trigger').exists();
  });

  test('the search palette only shows once its trigger is clicked', async function (assert) {
    await visit('/');

    assert.dom('.kolay__search').isNotVisible();

    await click('header .kolay__search__trigger');

    assert.dom('.kolay__search').isVisible();
  });
});
