import { warn } from '@ember/debug';
import { guidFor } from '@ember/object/internals';
import Component from '@glimmer/component';

/**
 * @typedef {object} PixProgressBarArgs
 * @property {number} value - Avancement, entre 0 et 1. Obligatoire.
 * @property {string} label - Description de l'avancement, lue par les lecteurs d'écran. Obligatoire.
 * @property {string} [percentageValue] - Texte affiché au-dessus de la barre, généralement le pourcentage.
 * @property {boolean} [hidePercentage] - Masque ce texte.
 * @property {string} [subtitle] - Précision affichée sous la barre.
 * @property {'primary' | 'success' | 'tertiary' | 'blue' | 'green' | 'purple'} [color] - Couleur de la barre. Par défaut : `primary`. Les valeurs `blue`, `green` et `purple` sont dépréciées.
 * @property {'light' | 'dark'} [themeMode] - Fond sur lequel la barre s'affiche. Par défaut : `light`.
 */

/**
 * @typedef {object} PixProgressBarSignature
 * @property {HTMLDivElement} Element
 * @property {PixProgressBarArgs} Args
 * @property {{}} Blocks
 */

export default class PixProgressBar extends Component {
  constructor(...args) {
    super(...args);

    warn(
      'PixProgressBar: you need to provide a number value between 0 and 1',
      this.args.value >= 0 && this.args.value <= 1,
      {
        id: 'pix-progress-bar.value.type.incorrect',
      },
    );

    warn('PixProgressBar: you need to provide a valid label', this.args.label, {
      id: 'pix-progress-bar.label.required',
    });

    this.id = guidFor(this);
  }

  get themeMode() {
    const availableMode = ['dark', 'light'];

    const themeMode =
      this.args.themeMode && availableMode.includes(this.args.themeMode)
        ? this.args.themeMode
        : 'light';

    return `pix-progress-bar--theme-${themeMode}`;
  }

  get colorClass() {
    const availableColor = [
      'primary',
      'success',
      'tertiary',
      // deprecated color
      'blue',
      'green',
      'purple',
    ];

    const color =
      this.args.color && availableColor.includes(this.args.color) ? this.args.color : 'primary';

    return `pix-progress-bar--content-${color}`;
  }

  <template>
    <div class="pix-progress-bar {{this.themeMode}} {{this.colorClass}}" ...attributes>
      {{#unless @hidePercentage}}
        <div class="pix-progress-bar__text" role="presentation">{{@percentageValue}}</div>
      {{/unless}}
      <label for={{this.id}} class="screen-reader-only">{{@label}}</label>
      <progress
        class="pix-progress-bar__bar"
        id={{this.id}}
        max="1"
        min="0"
        value={{@value}}
      >{{@percentageValue}}</progress>
      {{#if @subtitle}}
        <p class="pix-progress-bar__sub-title">{{@subtitle}}</p>
      {{/if}}
    </div>
  </template>
}
