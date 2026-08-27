import { PixIcon } from '@1024pix/nebulix-ember';
import { ICONS } from '@1024pix/nebulix-ember/helpers/icons';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

const COPY_FEEDBACK_DURATION = 2000;

const MESSAGES = {
  copied: 'Copié !',
  failed: 'Échec de la copie',
};

const NAMES = Object.keys(ICONS).sort((a, b) => a.localeCompare(b));

class IconCard extends Component {
  @tracked status = 'idle';

  #feedbackTimer;

  get hasPlainIcon() {
    return Boolean(ICONS[this.args.name].plainIcon);
  }

  get statusMessage() {
    return MESSAGES[this.status] ?? '';
  }

  get label() {
    return this.status === 'idle' ? this.args.name : this.statusMessage;
  }

  get ariaLabel() {
    return `Copier le nom de l'icône « ${this.args.name} »`;
  }

  copy = async () => {
    try {
      await navigator.clipboard.writeText(this.args.name);
      this.#flash('copied');
    } catch (error) {
      // eslint-disable-next-line no-console
      console.error(`Could not copy "${this.args.name}"`, error);
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
    <li class="icon-gallery__item">
      <button
        type="button"
        class="icon-gallery__button"
        aria-label={{this.ariaLabel}}
        {{on "click" this.copy}}
      >
        <span class="icon-gallery__icons">
          <PixIcon @name={{@name}} @ariaHidden={{true}} />
          {{#if this.hasPlainIcon}}
            <PixIcon @name={{@name}} @plainIcon={{true}} @ariaHidden={{true}} />
          {{/if}}
        </span>
        <span class="icon-gallery__name">{{this.label}}</span>
      </button>

      <span class="icon-gallery__announcement" role="status">
        {{this.statusMessage}}
      </span>
    </li>
  </template>
}

<template>
  <ul class="icon-gallery">
    {{#each NAMES as |name|}}
      <IconCard @name={{name}} />
    {{/each}}
  </ul>
</template>
