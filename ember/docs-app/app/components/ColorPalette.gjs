import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { modifier } from 'ember-modifier';

const COPY_FEEDBACK_DURATION = 2000;
const MAX_READ_FRAMES = 60;

const MESSAGES = {
  copied: 'Copié !',
  failed: 'Échec de la copie',
  missing: 'variable introuvable',
};

function toHex(computedColor) {
  const channels = computedColor.match(/\d+(?:\.\d+)?/g);

  if (!channels || channels.length < 3) return null;

  const hex = channels
    .slice(0, 3)
    .map((channel) => Number(channel).toString(16).padStart(2, '0'))
    .join('');

  return `#${hex.toUpperCase()}`;
}

class ColorShade extends Component {
  @tracked value;
  @tracked status = 'idle';

  #feedbackTimer;

  paintAndRead = modifier((element) => {
    const { variable } = this.args;

    // The shorthand, not `background-color`: a gradient is a background image.
    element.style.setProperty('background', `var(${variable})`);

    let frame;
    let frames = 0;

    const read = () => {
      if (!element.isConnected && frames++ < MAX_READ_FRAMES) {
        frame = requestAnimationFrame(read);

        return;
      }

      const styles = getComputedStyle(element);

      if (!styles.getPropertyValue(variable).trim()) {
        this.value = null;

        return;
      }

      this.value = styles.backgroundImage === 'none' ? toHex(styles.backgroundColor) : '';
    };

    read();

    return () => cancelAnimationFrame(frame);
  });

  get isMissing() {
    return this.value === null;
  }

  get statusMessage() {
    return MESSAGES[this.status] ?? '';
  }

  get valueLabel() {
    if (this.status !== 'idle') return this.statusMessage;
    if (this.value === undefined) return '';

    return this.isMissing ? MESSAGES.missing : this.value;
  }

  get ariaLabel() {
    const { variable } = this.args;

    if (this.isMissing) return `Variable ${variable} introuvable`;
    if (!this.value) return `Copier la variable ${variable}`;

    return `Copier la variable ${variable}, ${this.value}`;
  }

  copy = async () => {
    try {
      await navigator.clipboard.writeText(this.args.variable);
      this.#flash('copied');
    } catch (error) {
      // eslint-disable-next-line no-console
      console.error(`Could not copy "${this.args.variable}"`, error);
      this.#flash('failed');
    }
  };

  #flash(status) {
    clearTimeout(this.#feedbackTimer);
    this.status = status;
    this.#feedbackTimer = setTimeout(() => {
      this.status = 'idle';
    }, COPY_FEEDBACK_DURATION);
  }

  willDestroy() {
    super.willDestroy(...arguments);
    clearTimeout(this.#feedbackTimer);
  }

  <template>
    <li class="color-palette__shade">
      <button
        type="button"
        class="color-palette__button"
        aria-label={{this.ariaLabel}}
        disabled={{this.isMissing}}
        {{on "click" this.copy}}
      >
        <span
          class="color-palette__swatch {{if this.isMissing 'color-palette__swatch--missing'}}"
          aria-hidden="true"
          {{this.paintAndRead}}
        ></span>
        <span class="color-palette__name">{{@shade}}</span>
        <span class="color-palette__value">{{this.valueLabel}}</span>
      </button>

      <span class="color-palette__announcement" role="status">
        {{this.statusMessage}}
      </span>
    </li>
  </template>
}

<template>
  <section class="color-palette">
    <p class="color-palette__heading">
      <span class="color-palette__title">{{@title}}</span>
      <code class="color-palette__prefix">{{@prefix}}*</code>
    </p>

    <ul class="color-palette__shades">
      {{#each @shades as |shade|}}
        <ColorShade @shade={{shade}} @variable="{{@prefix}}{{shade}}" />
      {{/each}}
    </ul>
  </section>
</template>
