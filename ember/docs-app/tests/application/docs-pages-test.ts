import { currentURL, visit, waitFor } from '@ember/test-helpers';
import { setupApplicationTest } from 'ember-qunit';
import { module, test } from 'qunit';

/**
 * A mount whose `page` template is missing renders a blank outlet —
 * no build error, no lint error, no runtime error. These smoke tests are
 * what catches that.
 */
module('Application | docs pages', function (hooks) {
  setupApplicationTest(hooks);

  test('a docs page renders its compiled markdown', async function (assert) {
    await visit('/my-docs/test.md');

    // <Page> compiles the markdown in the browser, so the prose arrives
    // after the transition settles.
    await waitFor('h1');

    assert.dom('h1').hasText('Hello world');
    assert.dom().includesText('This is a test');
  });

  test('/ redirects to the co-located Home page', async function (assert) {
    await visit('/');

    // kolay always puts the co-located `app/templates` pages first, as the
    // "Home" group, so an index visit lands on the first of those.
    // An index page's URL drops the extension.
    assert.strictEqual(currentURL(), '/index');

    await waitFor('h1');

    assert.dom('h1').hasText('Pix UI documentation');
  });
});
