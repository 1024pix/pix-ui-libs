import { render } from '@1024pix/ember-testing-library';
import { PixTag } from '@1024pix/nebulix-ember';
import { click } from '@ember/test-helpers';
import { setupRenderingTest } from 'ember-qunit';
import { module, test } from 'qunit';
import sinon from 'sinon';

module('Integration | Component | pix-tag', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders the given content', async function (assert) {
    const screen = await render(
      <template>
        <PixTag>tag text</PixTag>
      </template>,
    );

    assert.dom(screen.getByText('tag text')).exists();
  });

  test('it renders with attributes override', async function (assert) {
    const screen = await render(
      <template><PixTag @color="secondary" aria-label="world" /></template>,
    );

    assert.dom(screen.getByLabelText('world')).exists();
  });

  module('Icons', function () {
    test('Display icons when it provided before', async function (assert) {
      const screen = await render(
        <template>
          <PixTag @iconBefore="close">tag text</PixTag>
        </template>,
      );

      assert.dom(screen.getByRole('img', { hidden: true })).exists();
    });

    test('Display icons when it provided after', async function (assert) {
      const screen = await render(
        <template>
          <PixTag @iconAfter="open">tag text</PixTag>
        </template>,
      );

      assert.dom(screen.getByRole('img', { hidden: true })).exists();
    });

    test('should not display icons when not provided', async function (assert) {
      const screen = await render(
        <template>
          <PixTag>tag text</PixTag>
        </template>,
      );

      assert.dom(screen.queryByRole('img', { hidden: true })).doesNotExist();
      assert.dom(screen.queryByRole('img')).doesNotExist();
    });
  });

  module('Action Button', function () {
    test('it displays remove button when onRemove is provided', async function (assert) {
      this.onRemove = sinon.stub();
      this.texts = { removeButtonLabel: 'Supprimer' };
      const screen = await render(
        <template>
          <PixTag @onRemove={{this.onRemove}} @texts={{this.texts}}>tag text</PixTag>
        </template>,
      );

      assert.dom(screen.getByRole('button', { name: 'Supprimer' })).exists();
    });

    test('it calls onRemove when button is clicked', async function (assert) {
      this.onRemove = sinon.stub();
      this.texts = { removeButtonLabel: 'Supprimer' };
      const screen = await render(
        <template>
          <PixTag @onRemove={{this.onRemove}} @texts={{this.texts}}>tag text</PixTag>
        </template>,
      );

      await click(screen.getByRole('button', { name: 'Supprimer' }));

      assert.ok(this.onRemove.calledOnce);
    });

    test('it does not display remove button when onRemove is not provided', async function (assert) {
      const screen = await render(
        <template>
          <PixTag>tag text</PixTag>
        </template>,
      );

      assert.dom(screen.queryByRole('button')).doesNotExist();
    });
  });
});
