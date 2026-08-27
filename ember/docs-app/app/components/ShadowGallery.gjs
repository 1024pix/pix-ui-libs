import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { modifier } from 'ember-modifier';

const COPY_FEEDBACK_DURATION = 2000;

const MESSAGES = {
  copied: 'Copié !',
  failed: 'Échec de la copie',
};

const applyShadow = modifier((element, [variable]) => {
  element.style.setProperty('box-shadow', `var(${variable})`);
});

class ShadowCard extends Component {
  @tracked status = 'idle';

  #feedbackTimer;

  get statusMessage() {
    return MESSAGES[this.status] ?? '';
  }

  get label() {
    return this.status === 'idle' ? this.args.variable : this.statusMessage;
  }

  get ariaLabel() {
    return `Copier la variable ${this.args.variable}`;
  }

  copy = async () => {
    try {
      await navigator.clipboard.writeText(this.args.variable);
      this.#flash('copied');
    } catch (error) {
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
    <li class="shadow-gallery__item">
      <button
        type="button"
        class="shadow-gallery__button"
        aria-label={{this.ariaLabel}}
        {{on "click" this.copy}}
      >
        <span
          class="shadow-gallery__surface"
          aria-hidden="true"
          {{applyShadow @variable}}
        ></span>
        <span class="shadow-gallery__name">{{this.label}}</span>
      </button>

      <span class="shadow-gallery__announcement" role="status">
        {{this.statusMessage}}
      </span>
    </li>
  </template>
}

<template>
  <section class="shadow-gallery">
    {{#if @title}}
      <p class="shadow-gallery__title">{{@title}}</p>
    {{/if}}

    <ul class="shadow-gallery__items">
      {{#each @names as |name|}}
        <ShadowCard @variable="{{@prefix}}{{name}}" />
      {{/each}}
    </ul>
  </section>
</template>
