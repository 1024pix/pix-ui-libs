import { render } from '@1024pix/ember-testing-library';
import { PixBlock } from '@1024pix/nebulix-ember';
import { setupRenderingTest } from 'ember-qunit';
import { module, test } from 'qunit';
import sinon from 'sinon';

module('Integration | Component | pix-block (strict)', function (hooks) {
  setupRenderingTest(hooks);

  const BLOCK_SELECTOR = '.pix-block';

  test('it renders the PixBlock', async function (assert) {
    // when
    await render(
      <template>
        <PixBlock @variant="certif" @condensed={{false}}>
          Je suis un beau bloc
        </PixBlock>
      </template>,
    );
    const blockElement = this.element.querySelector(BLOCK_SELECTOR);

    // then
    assert.contains('Je suis un beau bloc');
    assert.strictEqual(blockElement.className, 'pix-block pix-block--variant-certif');
  });

  module('when @variant parameter is not given', function (hooks) {
    let warnStub;

    hooks.beforeEach(function () {
      warnStub = sinon.stub(console, 'warn');
    });

    hooks.afterEach(function () {
      warnStub.restore();
    });

    test('it renders the primary PixBlock', async function (assert) {
      // when
      await render(
        <template>
          <PixBlock>
            Je suis un beau bloc
          </PixBlock>
        </template>,
      );
      const blockElement = this.element.querySelector(BLOCK_SELECTOR);

      // then
      assert.contains('Je suis un beau bloc');
      assert.strictEqual(blockElement.className, 'pix-block pix-block--variant-primary');
    });

    test('it should warn', async function (assert) {
      // when
      await render(
        <template>
          <PixBlock @variant="PIX APP">Coucou</PixBlock>
        </template>,
      );

      // then
      assert.ok(
        warnStub.calledWithExactly(
          'WARNING: PixBlock: @variant "PIX APP" should be primary, orga, certif, admin, modulix',
        ),
      );
    });
  });

  module('when @condensed parameter is true', function (hooks) {
    let warnStub;

    hooks.beforeEach(function () {
      warnStub = sinon.stub(console, 'warn');
    });

    hooks.afterEach(function () {
      warnStub.restore();
    });

    test('it renders the condensed PixBlock', async function (assert) {
      // when
      await render(
        <template>
          <PixBlock @condensed={{true}}>
            Je suis un beau bloc
          </PixBlock>
        </template>,
      );
      const blockElement = this.element.querySelector(BLOCK_SELECTOR);

      // then
      assert.contains('Je suis un beau bloc');
      assert.strictEqual(
        blockElement.className,
        'pix-block pix-block--variant-primary pix-block--condensed',
      );
    });
  });
});
