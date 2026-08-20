import { render } from '@1024pix/ember-testing-library';
import { PixIcon } from '@1024pix/nebulix-ember';
import { setupRenderingTest } from 'ember-qunit';
import { module, test } from 'qunit';

module('Integration | Component | pix-icon', function (hooks) {
  setupRenderingTest(hooks);

  const SPRITE_URL = '/@1024pix/nebulix-ember/svg/pix-sprite.svg';

  test('it points at the sprite served as a public asset', async function (assert) {
    // when
    await render(<template><PixIcon @name="add" /></template>);
    const use = this.element.querySelector('.pix-icon use');

    // then
    // An URL relative to the page would break on any route below the root, so
    // it has to stay absolute and match ember-addon.public-assets.
    assert.strictEqual(use.getAttribute('href'), `${SPRITE_URL}#add`);
  });

  test('it renders the plain variant of an icon', async function (assert) {
    // when
    await render(
      <template><PixIcon @name="bell" @plainIcon={{true}} /></template>,
    );
    const use = this.element.querySelector('.pix-icon use');

    // then
    assert.strictEqual(use.getAttribute('href'), `${SPRITE_URL}#bell_plain`);
  });

  test('it renders the default PixIcon title', async function (assert) {
    // when
    const screen = await render(<template><PixIcon @title='my-title' @icon='help' /></template>);

    // then
    assert.ok(screen.getByRole('img', { name: 'my-title' }));
  });
});
