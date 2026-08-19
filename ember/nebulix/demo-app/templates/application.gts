import { pageTitle } from 'ember-page-title';
import Component from "@glimmer/component";
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

import PixBlock from "../../src/components/layout/pix-block.gjs";
import PixIcon from "../../src/components/graphics/pix-icon.gjs";
import PixButton from "../../src/components/actions/pix-button.gjs";
import PixButtonLink from "../../src/components/actions/pix-button-link.gjs";
import PixButtonUpload from "../../src/components/actions/pix-button-upload.gjs";
import PixLabel from "../../src/components/forms/pix-label.gjs";
import PixInput from "../../src/components/forms/pix-input.gjs";
import PixInputCode from "../../src/components/forms/pix-input-code.gjs";
import PixCode from "../../src/components/forms/pix-code.gjs";
import PixInputPassword from "../../src/components/forms/pix-input-password.gjs";
import PixSearchInput from "../../src/components/forms/pix-search-input.gjs";
import PixTextarea from "../../src/components/forms/pix-textarea.gjs";
import PixSelectList from "../../src/components/forms/pix-select-list.gjs";
import PixRadioButton from "../../src/components/forms/pix-radio-button.gjs";
import PixCheckbox from "../../src/components/forms/pix-checkbox.gjs";
import PixAppLayout from "../../src/components/navigation/pix-app-layout.gjs";
import PixNavigation from "../../src/components/navigation/pix-navigation.gjs";
import PixNavigationButton from "../../src/components/navigation/pix-navigation-button.gjs";
import PixNavigationSeparator from "../../src/components/navigation/pix-navigation-separator.gjs";
import PixBreadcrumb from "../../src/components/navigation/pix-breadcrumb.gjs";
import PixSegmentedControl from "../../src/components/navigation/pix-segmented-control.gjs";
import PixModal from "../../src/components/overlay/pix-modal.gjs";
import PixSidePanel from "../../src/components/overlay/pix-side-panel.gjs";
import PixTabs from "../../src/components/navigation/pix-tabs.gjs";
import PixStepper from "../../src/components/navigation/pix-stepper.gjs";
import PixTooltip from "../../src/components/overlay/pix-tooltip.gjs";
import PixBannerAlert from "../../src/components/feedback/pix-banner-alert.gjs";

function noop(event) {
  console.log('noop noop!');
}

const selectListOptions = [{
  label: "Bretagne",
  value: "Bretagne",
  category: "Obscur"
}, {
  label: "Drôme",
  value: "Drôme",
  category: "Clair"
}
]

const breadCrumblinks = [{ label: 'Picoti, picota' }];

const steps = [
  { title: 'Informations', subtitle: 'Renseignez vos informations' },
  { title: 'Confirmation', subtitle: 'Vérifiez vos données' },
  { title: 'Validation', subtitle: 'Finalisez votre inscription' },
];

<template>
  {{pageTitle "Demo App"}}

<PixAppLayout @variant="certif">
  <:banner>
    <PixBannerAlert @type="environment">
      Attention c'est la bannière
    </PixBannerAlert>
  </:banner>
  <:navigation>
    <PixNavigation @navigationAriaLabel="navigation principale" @openLabel="Ouvrir le menu" @closeLabel="Fermer le menu">
        <:navElements>
          <PixNavigationButton href="https://pix.fr" @icon="book">Documentation</PixNavigationButton>
          <PixNavigationButton
            href="https://pix.fr"
            title="Pix.fr"
            @target="_blank"
            @icon="help"
          >Centre d'aide</PixNavigationButton>
        </:navElements>
        <:footer>
          <!-- Affichage du bloc de pied de page de la navigation -->
          <p>
            1 000 places disponibles
          </p>
          <PixNavigationSeparator />
          <p>
            Martin Dupond
          </p>
        </:footer>
    </PixNavigation>
  </:navigation>
  <:main>
      <PixStepper @steps={{steps}} @currentStep={{2}} />

      <PixBreadcrumb @links={{breadCrumblinks}}/>

      <PixTabs>
        <a href="#">Tab 1</a>
        <a href="#">Tab 2</a>
        <a href="#">Tab 3</a>
      </PixTabs>

      <PixTooltip @id="tooltip-1">
        <:triggerElement>
          <span>Fait fonctionner le tooltip</span>
        </:triggerElement>
        <:tooltip>
          My tooltip
        </:tooltip>
      </PixTooltip>

        <PixBlock>
          <PixIcon @name="brick" @plainIcon="true"/>
            Coucou c'est nous !
        </PixBlock>

        <PixButton>
          Dont click me!
        </PixButton>

        <PixButtonLink @href="https://www.pix.fr">
          I am a link !
        </PixButtonLink>

        <PixButtonUpload @id="upload-button" @onChange={{noop}}>
          Upload me if you can
        </PixButtonUpload>

        <PixLabel @requiredLabel="Obligatoire" @subLabel="Ceci est un sous-titre">
          Je suis label :)
        </PixLabel>

        <PixInput @validationStatus="error" placeholder="Ça marche pas">
          <:label>Error input</:label>
        </PixInput>
        <PixInput @validationStatus="success" placeholder="Ça marche">
          <:label>Success input</:label>
        </PixInput>

        <PixInputCode @ariaLabel="Champ" @legend="Code"  @numInputs={{6}} @inputType="number" />

        <PixCode @length={{4}}>
          <:label>Code carte bleue</:label>
        </PixCode>

        <PixInputPassword>
          <:label>Label pour Lionel</:label>
        </PixInputPassword>

        <PixSearchInput @debounceTimeInMs={{500}} @triggerFiltering={{noop}} >
          <:label>Search input</:label>
        </PixSearchInput>
        <div>
          <PixTextarea @value="Bon matin" @maxlength=100><:label> MOOD DU JOUR</:label></PixTextarea>
        </div>
        <PixSelectList @options={{selectListOptions}} />

        <fieldset>
          <legend>Ma gaga préférée</legend>
          <PixRadioButton name="radioprefere"><:label>RADIO gaga</:label></PixRadioButton>
          <PixRadioButton name="radioprefere"><:label>LADY gaga</:label></PixRadioButton>
        </fieldset>

        <fieldset>
          <legend>Ma gaga préférée ( choix multiple t'as vu )</legend>
          <PixCheckbox @variant="modulix" name="radioprefere"><:label>RADIO gaga</:label></PixCheckbox>
          <PixCheckbox @variant="modulix" name="radioprefere"><:label>LADY gaga</:label></PixCheckbox>
        </fieldset>

        <PixSegmentedControl>
          <:label>Mon super label</:label>
          <:viewA>Option 1</:viewA>
          <:viewB>Option 2</:viewB>
        </PixSegmentedControl>

        <PixBlock>
          <TestSidePanel/>
          <TestModale />
        </PixBlock>
    </:main>
  </PixAppLayout>
</template>


class TestModale extends Component {
  @tracked isModaleVisible = false;

  @action
  openModale() {
    this.isModaleVisible = true;
  }
  @action
  closeModale() {
    this.isModaleVisible = false;
  }


  <template>
    <PixButton
      @iconBefore="brick"
      @variant="secondary"
      @size="small"
      @triggerAction={{this.openModale}}
    >
      Afficher la modale
    </PixButton>
    <PixModal
      @title="Qu'est-ce qu'une modale ?"
      @showModal={{this.isModaleVisible}}
      @onCloseButtonClick={{this.closeModale}}
    >
     <:content>
      <p>
        Une fenêtre modale est, dans une interface graphique, une fenêtre qui prend le contrôle total du clavier et
        de l'écran. Elle est en général associée à une question à laquelle il est impératif que l'utilisateur
        réponde avant de poursuivre, ou de modifier quoi que ce soit. La fenêtre modale a pour propos : d'obtenir
        des informations de l'utilisateur (ces informations sont nécessaires pour réaliser une opération) ; de
        fournir une information à l'utilisateur (ce dernier doit en prendre connaissance avant de pouvoir continuer
        à utiliser l'application).
      </p>
     </:content>
     <:footer>
      <PixButton
        @variant="secondary"
        @isBorderVisible={{true}}
        @triggerAction={{this.closeModale}}
      >
        Annuler
      </PixButton>
     </:footer>
    </PixModal>
  </template>
}

class TestSidePanel extends Component {
  @tracked isSidePanelVisible = false;

  @action
  openSidePanel() {
    this.isSidePanelVisible = true;
  }
  @action
  closeSidePanel() {
    this.isSidePanelVisible = false;
  }


  <template>
    <PixButton
      @iconBefore="brick"
      @variant="secondary"
      @size="small"
      @triggerAction={{this.openSidePanel}}
    >
      Afficher le sidePanel
    </PixButton>
    <PixSidePanel
      @showSidePanel={{this.isSidePanelVisible}}
      @title="Filtrer"
      @subtitle="Sous-titre"
      @iconName="lightBulb"
      @onClose={{this.closeSidePanel}}
    >
     <:content>
      <p>
        Un SidePanel est, dans une interface graphique, une fenêtre qui prend le contrôle total du clavier et
        de l'écran. Elle est en général associée à du paramétrage d'écran.
      </p>
     </:content>
    </PixSidePanel>
  </template>
}
