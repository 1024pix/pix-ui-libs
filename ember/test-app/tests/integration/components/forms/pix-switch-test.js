import { render } from '@1024pix/ember-testing-library';
import { hbs } from 'ember-cli-htmlbars';
import { setupRenderingTest } from 'ember-qunit';
import { module, test } from 'qunit';

module('Integration | Component | switch', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders unchecked by default', async function (assert) {
    // when
    const screen = await render(hbs`<PixSwitch />`);

    // then
    assert.false(screen.getByRole('switch').checked);
  });

  test('it renders checked when @checked is true', async function (assert) {
    // when
    const screen = await render(hbs`<PixSwitch @checked={{true}} />`);

    // then
    assert.true(screen.getByRole('switch').checked);
  });

  test('it toggles when clicked', async function (assert) {
    // given
    this.set('checked', false);
    const screen = await render(hbs`<PixSwitch @checked={{this.checked}} />`);
    const switchElement = screen.getByRole('switch');

    // when
    switchElement.click();

    // then
    assert.true(switchElement.checked);
  });

  test('it toggles with Space key', async function (assert) {
    // given
    this.set('checked', false);
    const screen = await render(hbs`<PixSwitch @checked={{this.checked}} />`);
    const switchElement = screen.getByRole('switch');

    // when
    switchElement.focus();
    switchElement.click();

    // then
    assert.true(switchElement.checked);
  });

  test('it toggles with Enter key', async function (assert) {
    // given
    this.set('checked', false);
    const screen = await render(hbs`<PixSwitch @checked={{this.checked}} />`);
    const switchElement = screen.getByRole('switch');

    // when
    switchElement.focus();
    switchElement.click();

    // then
    assert.true(switchElement.checked);
  });

  test('it does not toggle when disabled', async function (assert) {
    // given
    this.set('checked', false);
    const screen = await render(hbs`<PixSwitch @checked={{this.checked}} @isDisabled={{true}} />`);
    const switchElement = screen.getByRole('switch');

    // when
    switchElement.click();

    // then
    assert.false(switchElement.checked);
  });

  test('it applies the correct variant class', async function (assert) {
    // given
    const variants = ['admin', 'orga', 'certif'];

    for (const variant of variants) {
      this.set('variant', variant);
      const screen = await render(hbs`<PixSwitch @variant={{this.variant}} />`);

      // then
      assert.true(
        screen.getByRole('switch').classList.contains(`pix-switch__input--variant-${variant}`),
        `contains variant class ${variant}`,
      );
    }
  });

  test('it applies the correct size class', async function (assert) {
    // given
    const sizes = ['small', 'medium', 'large'];

    for (const size of sizes) {
      this.set('size', size);
      const screen = await render(hbs`<PixSwitch @size={{this.size}} />`);

      // then
      assert.true(
        screen.getByRole('switch').classList.contains(`pix-switch__input--size-${size}`),
        `contains size class ${size}`,
      );
    }
  });

  test('it has aria-disabled when disabled', async function (assert) {
    // when
    const screen = await render(hbs`<PixSwitch @isDisabled={{true}} />`);

    // then
    assert.strictEqual(screen.getByRole('switch').getAttribute('aria-disabled'), 'true');
  });

  test('it has aria-checked reflecting checked state', async function (assert) {
    // given
    this.set('checked', true);
    const screen = await render(hbs`<PixSwitch @checked={{this.checked}} />`);

    // then
    assert.strictEqual(screen.getByRole('switch').getAttribute('aria-checked'), 'true');
  });
});
