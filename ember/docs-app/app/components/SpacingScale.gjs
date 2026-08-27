import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { modifier } from 'ember-modifier';

const COPY_FEEDBACK_DURATION = 2000;
const MAX_READ_FRAMES = 60;

const MESSAGES = {
  copied: 'Copié !',
  failed: 'Échec de la copie',
  missing: 'variable introuvable',
};

class SpacingStep extends Component {
  @tracked value;
  @tracked status = 'idle';

  #feedbackTimer;

  sizeAndRead = modifier((element) => {
    const { variable } = this.args;

    element.style.setProperty('width', `var(${variable})`);

    let frame;
    let frames = 0;

    const read = () => {
      if (!element.isConnected && frames++ < MAX_READ_FRAMES) {
        frame = requestAnimationFrame(read);

        return;
      }

      const declared = getComputedStyle(element).getPropertyValue(variable).trim();

      this.value = declared || null;
    };

    read();

    return () => cancelAnimationFrame(frame);
  });

  get isMissing() {
    return this.value === null;
  }

  get label() {
    if (this.status !== 'idle') return this.statusMessage;

    return this.isMissing ? MESSAGES.missing : this.value;
  }

  get statusMessage() {
    return MESSAGES[this.status] ?? '';
  }

  get ariaLabel() {
    const { variable } = this.args;

    if (this.isMissing) return `Variable ${variable} introuvable`;

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
    <li class="spacing-scale__step">
      <button
        type="button"
        class="spacing-scale__button"
        aria-label={{this.ariaLabel}}
        disabled={{this.isMissing}}
        {{on "click" this.copy}}
      >
        <span class="spacing-scale__name">{{@variable}}</span>
        <span
          class="spacing-scale__bar {{if this.isMissing 'spacing-scale__bar--missing'}}"
          aria-hidden="true"
          {{this.sizeAndRead}}
        ></span>
        <span class="spacing-scale__value">{{this.label}}</span>
      </button>

      <span class="spacing-scale__announcement" role="status">
        {{this.statusMessage}}
      </span>
    </li>
  </template>
}

<template>
  <ul class="spacing-scale">
    {{#each @names as |name|}}
      <SpacingStep @variable="{{@prefix}}{{name}}" />
    {{/each}}
  </ul>
</template>
