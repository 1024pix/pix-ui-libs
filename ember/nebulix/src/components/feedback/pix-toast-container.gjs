import { service } from '@ember/service';
import Component from '@glimmer/component';

import PixToast from './pix-toast.gjs';

/**
 * @typedef {object} PixToastContainerArgs
 * @property {string} closeButtonAriaLabel - Nom du bouton de fermeture des notifications, lu par les lecteurs d'écran. Obligatoire.
 */

/**
 * @typedef {object} PixToastContainerSignature
 * @property {null} Element
 * @property {PixToastContainerArgs} Args
 * @property {{}} Blocks
 */

export default class PixToastContainer extends Component {
  @service pixToast;

  <template>
    <div class="pix-toast-container">
      {{#each this.pixToast.content as |toast|}}
        <PixToast @toast={{toast}} @closeButtonAriaLabel={{@closeButtonAriaLabel}} />
      {{/each}}
    </div>
  </template>
}
