import { clickByName, render } from '@1024pix/ember-testing-library';
import { PixCheckbox } from '@1024pix/nebulix-ember';
import { setupRenderingTest } from 'ember-qunit';
import { module, test } from 'qunit';
import sinon from 'sinon';

module('Integration | Component | checkbox', function (hooks) {
  setupRenderingTest(hooks);

  module('it should be possible to check the checkbox', function () {
    test('when label is displayed', async function (assert) {
      // when
      const screen = await render(
        <template>
          <PixCheckbox>
            <:label>Recevoir la newsletter</:label></PixCheckbox>
        </template>,
      );
      await clickByName('Recevoir la newsletter');

      // then
      assert.true(screen.getByLabelText('Recevoir la newsletter').checked);
    });

    test('when label is hidden', async function (assert) {
      // when
      const screen = await render(
        <template>
          <PixCheckbox @screenReaderOnly={{true}}>
            <:label>Recevoir la newsletter</:label></PixCheckbox>
        </template>,
      );
      await clickByName('Recevoir la newsletter');

      // then
      assert.true(screen.getByLabelText('Recevoir la newsletter').checked);
    });
  });

  test('it should be possible to insert html in label', async function (assert) {
    // given & when
    const screen = await render(
      <template>
        <PixCheckbox>
          <:label>Accepter les cgu,
            <a href="https://cgu.example.net">voir ici</a></:label></PixCheckbox>
      </template>,
    );

    // then
    assert.dom(screen.getByLabelText('Accepter les cgu, voir ici')).exists();
  });

  test('it should be possible to control state', async function (assert) {
    // given
    this.set('checked', false);

    const screen = await render(
      <template>
        <PixCheckbox @checked={{this.checked}}>
          <:label>Recevoir la newsletter</:label></PixCheckbox>
      </template>,
    );
    const checkbox = screen.getByLabelText('Recevoir la newsletter');
    assert.false(checkbox.checked);

    // when
    this.set('checked', true);

    // then
    assert.true(checkbox.checked);
  });

  test('it should display the required and sub label given in @texts', async function (assert) {
    // given
    const texts = { requiredLabel: 'Obligatoire', subLabel: 'Complément' };

    // when
    const screen = await render(
      <template>
        <PixCheckbox @texts={{texts}}>
          <:label>Recevoir la newsletter</:label></PixCheckbox>
      </template>,
    );

    // then
    assert.dom(screen.getByTitle('Obligatoire')).exists();
    assert.dom(screen.getByText('Complément')).exists();
  });

  module('@isDisabled', function (hooks) {
    let warnStub;

    hooks.beforeEach(function () {
      warnStub = sinon.stub(console, 'warn');
    });

    hooks.afterEach(function () {
      warnStub.restore();
    });

    test(`it should not be possible to interact when @isDisabled={{true}}`, async function (assert) {
      // given
      const isDisabled = true;

      const screen = await render(
        <template>
          <PixCheckbox checked @isDisabled={{isDisabled}}>
            <:label>Recevoir la newsletter</:label></PixCheckbox>
        </template>,
      );
      const checkbox = screen.getByRole('checkbox', {
        name: 'Recevoir la newsletter',
        disabled: true,
      });

      assert.false(warnStub.called);
      assert.true(checkbox.checked, 'Checkbox has been set to checked by default');
      assert.strictEqual(
        checkbox.getAttribute('aria-disabled'),
        'true',
        '`aria-disabled` should be forced to "true" else VoiceOver don\'t consider the input as "dimmed"',
      );

      // when
      await clickByName('Recevoir la newsletter'); // should not throw!

      // then
      assert.true(checkbox.checked, "Checkbox has changed state, but shouldn't have");
    });

    test(`it should read success state info if given`, async function (assert) {
      // given
      const isDisabled = true;
      const texts = { stateSuccess: 'Sélection correcte' };

      // when
      const screen = await render(
        <template>
          <PixCheckbox checked @isDisabled={{isDisabled}} @state="success" @texts={{texts}}>
            <:label>Recevoir la newsletter</:label></PixCheckbox>
        </template>,
      );

      // then
      assert
        .dom(
          screen.getByRole('checkbox', {
            description: 'Sélection correcte',
            hidden: true,
          }),
        )
        .exists();
    });

    test(`it should read error state info if given`, async function (assert) {
      // given
      const isDisabled = true;
      const texts = { stateError: 'Sélection incorrecte' };

      // when
      const screen = await render(
        <template>
          <PixCheckbox checked @isDisabled={{isDisabled}} @state="error" @texts={{texts}}>
            <:label>Recevoir la newsletter</:label></PixCheckbox>
        </template>,
      );

      // then
      assert
        .dom(
          screen.getByRole('checkbox', {
            description: 'Sélection incorrecte',
            hidden: true,
          }),
        )
        .exists();
    });

    test(`it should read declarative state info if given`, async function (assert) {
      // given
      const isDisabled = true;
      const texts = { stateDeclarative: 'Sélection sans bonne ou mauvaise réponse' };

      // when
      const screen = await render(
        <template>
          <PixCheckbox checked @isDisabled={{isDisabled}} @state="declarative" @texts={{texts}}>
            <:label>La galette des rois</:label></PixCheckbox>
        </template>,
      );

      // then
      assert
        .dom(
          screen.getByRole('checkbox', {
            description: 'Sélection sans bonne ou mauvaise réponse',
            hidden: true,
          }),
        )
        .exists();
    });

    ['true', 'false', 'null', 'undefined'].forEach(function (testCase) {
      test(`it should not be possible to interact when @isDisabled="${testCase}"`, async function (assert) {
        // given
        const isDisabled = testCase;
        const screen = await render(
          <template>
            <PixCheckbox checked @isDisabled={{isDisabled}}>
              <:label>Recevoir la newsletter</:label></PixCheckbox>
          </template>,
        );
        const checkbox = screen.getByRole('checkbox', {
          name: 'Recevoir la newsletter',
          disabled: true,
        });

        assert.ok(
          warnStub.calledWithExactly(
            'WARNING: PixCheckbox: @isDisabled attribute should be a boolean.',
          ),
        );
        assert.true(checkbox.checked, 'Checkbox has been set to checked by default');
        assert.strictEqual(
          checkbox.getAttribute('aria-disabled'),
          'true',
          '`aria-disabled` should be forced to "true" else VoiceOver don\'t consider the input as "dimmed"',
        );

        // when
        await clickByName('Recevoir la newsletter'); // should not throw!

        // then
        assert.true(checkbox.checked, "Checkbox has changed state, but shouldn't have");
      });
    });

    [false, null, undefined].forEach(function (testCase) {
      test(`it should be possible to interact when @isDisabled={{${testCase}}}`, async function (assert) {
        // given
        const isDisabled = testCase;
        const screen = await render(
          <template>
            <PixCheckbox checked @isDisabled={{isDisabled}}>
              <:label>Recevoir la newsletter</:label></PixCheckbox>
          </template>,
        );
        const checkbox = screen.getByRole('checkbox', {
          name: 'Recevoir la newsletter',
          disabled: true,
        });

        assert.false(warnStub.called);
        assert.true(checkbox.checked, 'Checkbox has been set to checked by default');
        assert.strictEqual(
          checkbox.getAttribute('aria-disabled'),
          null,
          '`aria-disabled` should not be set',
        );

        // when
        await clickByName('Recevoir la newsletter');

        // then
        assert.false(checkbox.checked, 'Checkbox should have changed state');
      });
    });
  });

  module('when disabled', function () {
    test(`it should not be possible to interact when disabled={{true}}`, async function (assert) {
      // given
      const disabled = true;
      const screen = await render(
        <template>
          <PixCheckbox checked disabled={{disabled}}>
            <:label>Recevoir la newsletter</:label></PixCheckbox>
        </template>,
      );
      const checkbox = screen.getByRole('checkbox', {
        name: 'Recevoir la newsletter',
        disabled: true,
      });
      assert.true(checkbox.checked, 'Checkbox has been set to checked by default');

      try {
        // when
        await clickByName('Recevoir la newsletter');

        assert.true(false, 'It should not be possible to interact with disabled Checkbox');
      } catch {
        // then state did not change
        assert.true(checkbox.checked, "Checkbox has changed state, but shouldn't have");
      }
    });

    ['true', 'false', 'null', 'undefined'].forEach(function (testCase) {
      test(`it should not be possible to interact when disabled="${testCase}"`, async function (assert) {
        // given
        const disabled = testCase;
        const screen = await render(
          <template>
            <PixCheckbox checked disabled={{disabled}}>
              <:label>Recevoir la newsletter</:label></PixCheckbox>
          </template>,
        );
        const checkbox = screen.getByRole('checkbox', {
          name: 'Recevoir la newsletter',
          disabled: true,
        });
        assert.true(checkbox.checked, 'Checkbox has been set to checked by default');

        try {
          // when
          await clickByName('Recevoir la newsletter');

          assert.true(false, 'It should not be possible to interact with disabled Checkbox');
        } catch {
          // then state did not change
          assert.true(checkbox.checked, "Checkbox has changed state, but shouldn't have");
        }
      });
    });

    [false, null, undefined].forEach(function (testCase) {
      test(`it should be possible to interact when disabled={{${testCase}}}`, async function (assert) {
        // given
        const disabled = testCase;
        const screen = await render(
          <template>
            <PixCheckbox checked disabled={{disabled}}>
              <:label>Recevoir la newsletter</:label></PixCheckbox>
          </template>,
        );
        const checkbox = screen.getByRole('checkbox', {
          name: 'Recevoir la newsletter',
          disabled: true,
        });
        assert.true(checkbox.checked, 'Checkbox has been set to checked by default');

        // when
        await clickByName('Recevoir la newsletter');

        // then
        assert.false(checkbox.checked, 'Checkbox should have changed state');
      });
    });
  });
});
