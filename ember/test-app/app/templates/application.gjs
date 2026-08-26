import {
  PixAppLayout,
  PixBannerAlert,
  PixButton,
  PixNavigation,
  PixNavigationButton,
  PixNavigationSeparator,
  PixStructureSwitcher,
} from '@1024pix/nebulix-ember';
import { action } from '@ember/object';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class ApplicationPage extends Component {
  @tracked
  structure = this.structures[2];
  structures = [
    {
      value: 1,
      label: 'SCO Institut médico-éducatif professionnel Marguerite Sinclair',
    },
    {
      value: 2,
      label: "L'école du design",
    },
    {
      value: 3,
      label:
        "INSTITUT D'ENSEIGNEMENT TECHNIQUE DE MECANIQUE ET D'ELECTRICITE INSTITUT MARGUERITE MASSART",
    },
    {
      value: 4,
      label: 'un_super_d_organization_qui_ne_comporte_aucun_espace_oui_oui_c_est_du_vecu',
    },
    {
      value: 5,
      label: 'SCO Institut médico-éducatif professionnel Marguerite Sinclair',
    },
    {
      value: 6,
      label: "L'école du design",
    },
    {
      value: 7,
      label:
        "INSTITUT D'ENSEIGNEMENT TECHNIQUE DE MECANIQUE ET D'ELECTRICITE INSTITUT MARGUERITE MASSART",
    },
    {
      value: 8,
      label: 'un_super_d_organization_qui_ne_comporte_aucun_espace_oui_oui_c_est_du_vecu',
    },
  ];

  @action
  setStructure(option) {
    this.structure = option;
  }
  <template>
    <PixAppLayout @variant="orga">
      <:banner>
        <PixBannerAlert @type="warning">
          WARNING ceci n'est pas un exercice | WARNING ceci n'est pas un exercice | WARNING ceci
          n'est pas un exercice | WARNING ceci n'est pas un exercice | WARNING ceci n'est pas un
          exercice | WARNING ceci n'est pas un exercice | WARNING ceci n'est pas un exercice |
          WARNING ceci n'est pas un exercice | WARNING ceci n'est pas un exercice | WARNING ceci
          n'est pas un exercice
        </PixBannerAlert>
      </:banner>

      <:navigation>
        <PixNavigation>
          <:brand>
            <a href="/">
              <img src="/pix-orga.svg" alt="pix orga" />
            </a>
          </:brand>
          <:navElements>
            <PixNavigationButton href="/tests" @icon="bolt">Lancer les tests</PixNavigationButton>
            <PixNavigationButton @route="modal-page" @icon="campaign">
              PixModal
            </PixNavigationButton>
            <PixNavigationButton @route="select-page" @icon="book">PixSelect</PixNavigationButton>
            <PixNavigationButton
              @route="sidepanel-page"
              @icon="doorOpen"
            >PixSidePanel</PixNavigationButton>
            <PixNavigationButton
              @route="tooltip-page"
              @icon="signpost"
            >PixTooltip</PixNavigationButton>
            <PixNavigationButton
              @route="table-page"
              @icon="assignment"
            >PixTable</PixNavigationButton>
            <PixNavigationButton @route="gauge-page" @icon="barsUp">PixGauge</PixNavigationButton>
            <PixNavigationButton
              @route="button-page"
              @icon="lightBulb"
            >PixButton</PixNavigationButton>
            <PixNavigationButton
              @route="stepper-page"
              @icon="brick"
            >PixStepper</PixNavigationButton>
            <PixNavigationButton
              @route="checkbox-page"
              @icon="check"
            >PixCheckbox</PixNavigationButton>
            <PixNavigationButton
              href="https://pix.fr"
              @icon="book"
            >Documentation</PixNavigationButton>
            <PixNavigationButton
              href="https://pix.fr"
              title="Pix.fr"
              @target="_blank"
              @icon="help"
            >Centre d'aide</PixNavigationButton>
            <PixButton
              aria-disabled="true"
              @iconBefore="cancel"
              @isDisabled={{true}}
              @variant="primary"
            >Test mobile disabled</PixButton>
          </:navElements>
          <:footer>
            <p>
              1 000 places disponibles
            </p>
            <PixNavigationSeparator />
            <p>
              Martin Dupond
            </p>
            <p>{{this.structure.label}}</p>
            <PixStructureSwitcher
              @label="Changer d'organisation"
              @structures={{this.structures}}
              @value={{this.structure.value}}
              @onChange={{this.setStructure}}
            />
            <PixButton @triggerAction={{this.disconnect}} @variant="tertiary">Se déconnecter</PixButton>
          </:footer>
        </PixNavigation>
      </:navigation>
      <:main>
        {{outlet}}
      </:main>
      <:footer>
        <footer>
          <ul>
            <li>
              <a href="https://pix.fr/mentions-legales" target="_blank" rel="noopener noreferrer">
                Mentions légales
              </a>
            </li>
            <li>
              <a
                href="https://pix.fr/accessibilite-pix-certif"
                target="_blank"
                rel="noopener noreferrer"
              >
                Accessibilité : partiellement conforme
              </a>
            </li>
          </ul>
          <div>
            <span>© 2024 Pix</span>
          </div>
        </footer>
      </:footer>
    </PixAppLayout>
  </template>
}
