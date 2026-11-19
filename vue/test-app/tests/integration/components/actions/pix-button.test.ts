import { PixButton } from '@1024pix/nebulix-vue';
import userEvent from '@testing-library/user-event';
import { render, screen } from '@testing-library/vue';
import { describe, expect, test, vi } from 'vitest';
import { h } from 'vue';

const noop = () => {};

function renderButton(props: Record<string, unknown> = {}, label = 'Mon bouton') {
  return render(PixButton, {
    props: { triggerAction: noop, ...props },
    slots: { default: () => label },
  });
}

describe('PixButton', () => {
  test('it renders a native button with the given label', () => {
    renderButton();

    const button = screen.getByRole('button', { name: 'Mon bouton' });
    expect(button).toHaveAttribute('type', 'button');
    expect(button).toHaveClass('pix-button', 'pix-button--size-small', 'pix-button--primary');
    expect(button).not.toHaveAttribute('aria-disabled');
  });

  test('it renders the given variant, size and type', () => {
    renderButton({ variant: 'secondary', size: 'large', type: 'submit' });

    const button = screen.getByRole('button', { name: 'Mon bouton' });
    expect(button).toHaveAttribute('type', 'submit');
    expect(button).toHaveClass('pix-button--secondary', 'pix-button--size-large');
  });

  test('it renders a border when isBorderVisible is true', () => {
    renderButton({ variant: 'transparent-dark', isBorderVisible: true });

    expect(screen.getByRole('button', { name: 'Mon bouton' })).toHaveClass('pix-button--border');
  });

  test('it forwards attributes to the button', () => {
    renderButton({ 'aria-label': 'Retour à la page précédente', class: 'custom' });

    const button = screen.getByRole('button', { name: 'Retour à la page précédente' });
    expect(button).toHaveClass('pix-button', 'custom');
  });

  test('it renders icons before and after the label, hidden from screen readers', () => {
    const { container } = renderButton({
      iconBefore: 'brick',
      plainIconBefore: true,
      iconAfter: 'arrowRight',
    });

    const iconBefore = container.querySelector('.pix-button__icon--before');
    const iconAfter = container.querySelector('.pix-button__icon--after');
    expect(iconBefore).toHaveAttribute('aria-hidden', 'true');
    expect(iconBefore?.querySelector('use')).toHaveAttribute(
      'href',
      '/@1024pix/nebulix-vue/svg/pix-sprite.svg#brick_plain',
    );
    expect(iconAfter?.querySelector('use')).toHaveAttribute(
      'href',
      '/@1024pix/nebulix-vue/svg/pix-sprite.svg#arrowRight',
    );
    expect(screen.getByRole('button', { name: 'Mon bouton' })).toBeVisible();
  });

  test('it calls triggerAction on click', async () => {
    const triggerAction = vi.fn();
    renderButton({ triggerAction });

    await userEvent.click(screen.getByRole('button', { name: 'Mon bouton' }));

    expect(triggerAction).toHaveBeenCalledOnce();
    expect(triggerAction.mock.calls[0][0]).toBeInstanceOf(MouseEvent);
  });

  test('it warns when triggerAction is missing on a non-submit button', () => {
    const warn = vi.spyOn(console, 'warn').mockImplementation(noop);

    render(PixButton, { slots: { default: () => 'Mon bouton' } });

    const messages = warn.mock.calls.map(([message]) => String(message));
    expect(messages).toContainEqual(
      expect.stringContaining('PixButton: triggerAction should be a function'),
    );
  });

  describe('when isDisabled is true', () => {
    test('it stays focusable and is marked as disabled', () => {
      renderButton({ isDisabled: true });

      const button = screen.getByRole('button', { name: 'Mon bouton' });
      expect(button).toHaveAttribute('aria-disabled', 'true');
      expect(button).not.toBeDisabled();
    });

    test('it does not call triggerAction on click', async () => {
      const triggerAction = vi.fn();
      renderButton({ triggerAction, isDisabled: true });

      await userEvent.click(screen.getByRole('button', { name: 'Mon bouton' }));

      expect(triggerAction).not.toHaveBeenCalled();
    });

    test('it does not submit its form', async () => {
      const onSubmit = vi.fn((event: Event) => event.preventDefault());
      render({
        render: () =>
          h('form', { onSubmit }, [
            h(PixButton, { type: 'submit', isDisabled: true }, () => 'Envoyer'),
          ]),
      });

      await userEvent.click(screen.getByRole('button', { name: 'Envoyer' }));

      expect(onSubmit).not.toHaveBeenCalled();
    });
  });

  describe('when type is submit and there is no triggerAction', () => {
    test('it submits its form', async () => {
      const onSubmit = vi.fn((event: Event) => event.preventDefault());
      render({
        render: () => h('form', { onSubmit }, [h(PixButton, { type: 'submit' }, () => 'Envoyer')]),
      });

      await userEvent.click(screen.getByRole('button', { name: 'Envoyer' }));

      expect(onSubmit).toHaveBeenCalledOnce();
    });
  });

  describe('when triggerAction returns a promise', () => {
    test('it displays a loading state until the promise settles, and ignores clicks meanwhile', async () => {
      let resolveAction: () => void = noop;
      const triggerAction = vi.fn(
        () =>
          new Promise<void>((resolve) => {
            resolveAction = resolve;
          }),
      );
      const { container } = renderButton({ triggerAction });
      const button = screen.getByRole('button', { name: 'Mon bouton' });

      await userEvent.click(button);

      expect(container.querySelector('.loader')).toBeInTheDocument();
      expect(button).toHaveAttribute('aria-disabled', 'true');

      await userEvent.click(button);
      expect(triggerAction).toHaveBeenCalledOnce();

      resolveAction();
      await vi.waitFor(() => expect(container.querySelector('.loader')).not.toBeInTheDocument());
      expect(button).not.toHaveAttribute('aria-disabled');
    });

    test('it leaves the loading state when the promise rejects', async () => {
      const error = new Error('échec');
      let rejectAction: (reason: Error) => void = noop;
      const triggerAction = () =>
        new Promise<void>((_, reject) => {
          rejectAction = reject;
        });
      const onError = vi.fn();
      const { container } = render(PixButton, {
        props: { triggerAction },
        slots: { default: () => 'Mon bouton' },
        global: { config: { errorHandler: onError } },
      });

      await userEvent.click(screen.getByRole('button', { name: 'Mon bouton' }));
      expect(container.querySelector('.loader')).toBeInTheDocument();

      rejectAction(error);
      await vi.waitFor(() => expect(container.querySelector('.loader')).not.toBeInTheDocument());
      expect(onError).toHaveBeenCalledWith(error, expect.anything(), expect.anything());
    });
  });

  describe('when isLoading is true', () => {
    test('it displays a loader and keeps the label in the accessible name', () => {
      const { container } = renderButton({ isLoading: true });

      const button = screen.getByRole('button', { name: 'Mon bouton' });
      expect(button).toHaveAttribute('aria-disabled', 'true');
      expect(container.querySelector('.loader__not-visible-text')).toHaveTextContent('Mon bouton');
    });

    test('it displays a white loader by default', () => {
      const { container } = renderButton({ isLoading: true });

      expect(container.querySelector('.loader')).toHaveClass('loader--white');
    });

    test('it displays a current color loader on tertiary variant', () => {
      const { container } = renderButton({ isLoading: true, variant: 'tertiary' });

      expect(container.querySelector('.loader')).toHaveClass('loader--current');
    });

    test('it displays the loader with the given loadingColor', () => {
      const { container } = renderButton({ isLoading: true, loadingColor: 'grey' });

      expect(container.querySelector('.loader')).toHaveClass('loader--grey');
    });
  });
});
