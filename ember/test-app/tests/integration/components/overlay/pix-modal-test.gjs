import { render, within } from '@1024pix/ember-testing-library';
import { PixModal } from '@1024pix/nebulix-ember';
import { click, triggerEvent } from '@ember/test-helpers';
import { setupRenderingTest } from 'ember-qunit';
import { module, test } from 'qunit';
import sinon from 'sinon';

module('Integration | Component | modal', function (hooks) {
  setupRenderingTest(hooks);

  module('when showModal is equal true', function () {
    test('it renders the default PixModal', async function (assert) {
      // given
      const title = "It's a modal!";
      const showModal = true;

      // when
      const screen = await render(
        <template>
          <PixModal @title={{title}} @showModal={{showModal}}>
            <:content>
              content
            </:content>
            <:footer>
              footer
            </:footer>
          </PixModal>
        </template>,
      );

      // then
      assert.ok(screen.getByRole('dialog'));
      assert.ok(screen.queryByRole('heading', { name: title }));
      assert.contains('content');
      assert.contains('footer');
    });

    module('when close button is clicked', function () {
      test('it should call onClose function passed in argument', async function (assert) {
        // given
        const title = 'Close me baby one more time';
        const showModal = true;
        const onCloseButtonClick = sinon.stub();

        // when
        const screen = await render(
          <template>
            <PixModal
              @title={{title}}
              @onCloseButtonClick={{onCloseButtonClick}}
              @showModal={{showModal}}
            >
              content
            </PixModal>
          </template>,
        );
        await click(screen.getByRole('button', { name: /Fermer/ }));

        // then
        assert.ok(onCloseButtonClick.calledOnce);
      });
    });

    module('when the cancel event is triggered (escape key)', function () {
      test('it should call onClose function passed in argument', async function (assert) {
        // given
        const title = 'Close me baby one more time';
        const showModal = true;
        const onCloseButtonClick = sinon.stub();

        // when
        const screen = await render(
          <template>
            <PixModal
              @title={{title}}
              @onCloseButtonClick={{onCloseButtonClick}}
              @showModal={{showModal}}
            >
              content
            </PixModal>
          </template>,
        );
        await triggerEvent(screen.getByRole('dialog'), 'cancel');

        // then
        assert.ok(onCloseButtonClick.calledOnce);
      });
    });
  });

  module('when showModal is false', function () {
    test('it should not show modal', async function (assert) {
      // given
      const title = "It's a modal!";
      const showModal = false;

      // when
      const screen = await render(
        <template>
          <PixModal @title={{title}} @showModal={{showModal}}>
            <:content>
              content
            </:content>
            <:footer>
              footer
            </:footer>
          </PixModal>
        </template>,
      );

      // then
      assert.notOk(screen.queryByRole('dialog'));
      assert.notOk(screen.queryByRole('heading', { name: title }));
    });
  });

  module('variants', function () {
    module('when variant is not provided', function () {
      test('it should apply default style', async function (assert) {
        // given
        const title = 'Modal with no variant';
        const showModal = true;

        // when
        const screen = await render(
          <template>
            <PixModal @title={{title}} @showModal={{showModal}}>
              <:content>
                content
              </:content>
              <:footer>
                footer
              </:footer>
            </PixModal>
          </template>,
        );

        // then
        const dialog = screen.getByRole('dialog', { name: 'Modal with no variant' });

        assert.dom(dialog.querySelector('.pix-modal')).hasClass('pix-modal--default');
        assert.dom(dialog.querySelector('.pix-modal-header')).hasClass('pix-modal-header--default');
      });
    });

    module('when variant is "default"', function () {
      test('it should apply default style', async function (assert) {
        // given
        const title = 'Modal with "default" variant';
        const showModal = true;

        // when
        const screen = await render(
          <template>
            <PixModal @title={{title}} @showModal={{showModal}} @variant="default">
              <:content>
                content
              </:content>
              <:footer>
                footer
              </:footer>
            </PixModal>
          </template>,
        );

        // then
        const dialog = screen.getByRole('dialog', { name: 'Modal with "default" variant' });

        assert.dom(dialog.querySelector('.pix-modal')).hasClass('pix-modal--default');
        assert.dom(dialog.querySelector('.pix-modal-header')).hasClass('pix-modal-header--default');
      });
    });

    module('when variant is "orga"', function () {
      test('it should apply orga style', async function (assert) {
        // given
        const title = 'Modal with "orga" variant';
        const showModal = true;

        // when
        const screen = await render(
          <template>
            <PixModal @title={{title}} @showModal={{showModal}} @variant="orga">
              <:content>
                content
              </:content>
              <:footer>
                footer
              </:footer>
            </PixModal>
          </template>,
        );

        // then
        const dialog = screen.getByRole('dialog', { name: 'Modal with "orga" variant' });

        assert.dom(dialog.querySelector('.pix-modal')).hasClass('pix-modal--orga');
        assert.dom(dialog.querySelector('.pix-modal-header')).hasClass('pix-modal-header--orga');
      });
    });

    module('when variant is "certif"', function () {
      test('it should apply certif style', async function (assert) {
        // given
        const title = 'Modal with "certif" variant';
        const showModal = true;

        // when
        const screen = await render(
          <template>
            <PixModal @title={{title}} @showModal={{showModal}} @variant="certif">
              <:content>
                content
              </:content>
              <:footer>
                footer
              </:footer>
            </PixModal>
          </template>,
        );

        // then
        const dialog = screen.getByRole('dialog', { name: 'Modal with "certif" variant' });

        assert.dom(dialog.querySelector('.pix-modal')).hasClass('pix-modal--certif');
        assert.dom(dialog.querySelector('.pix-modal-header')).hasClass('pix-modal-header--certif');
      });
    });
  });

  module('when @iconName is provided', function () {
    test('it should render icon in header', async function (assert) {
      // when
      await render(<template><PixModal @title="Titre" @iconName="lightBulb" /></template>);

      // then
      const headerTitleSection = this.element.querySelector('.pix-modal-header__title-section');

      const icon = within(headerTitleSection).getByRole('img', { hidden: true });

      assert.true(icon.innerHTML.includes('lightBulb'));
    });
  });

  module('when @iconName is not provided', function () {
    test('it should not render icon', async function (assert) {
      // when
      await render(<template><PixModal @title="Titre" /></template>);

      // then
      const headerTitleSection = this.element.querySelector('.pix-modal-header__title-section');

      const icon = within(headerTitleSection).queryByRole('img', { hidden: true });

      assert.dom(icon).doesNotExist();
    });
  });

  module('when @subtitle is provided', function () {
    test('it should render subtitle in header', async function (assert) {
      // when
      await render(<template><PixModal @title="Titre" @subtitle="Sous titre" /></template>);

      // then
      const headerTitleSection = this.element.querySelector('.pix-modal-header__title-section');

      const subtitle = within(headerTitleSection).getByText('Sous titre');

      assert.dom(subtitle).exists();
    });
  });

  module('when @subtitle is not provided', function () {
    test('it should not render subtitle', async function (assert) {
      // when
      await render(<template><PixModal @title="Titre" /></template>);

      // then
      const subtitleElement = this.element.querySelector('.pix-modal-headersubtitle');

      assert.dom(subtitleElement).doesNotExist();
    });
  });
});
