import { pageTitle } from 'ember-page-title';

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

const breadCrumblinks = [
    {
      label: 'Picoti, picota'
    },
  ];

<template>
  {{pageTitle "Demo App"}}

<PixAppLayout @variant="certif">
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
    <h1>Addon DEMO APP Nebulix !</h1>
      <PixBreadcrumb @links={{breadCrumblinks}}/>
      <PixBlock>
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

        <PixTextarea @value="Bon matin" @maxlength=100><:label> MOOD DU JOUR</:label></PixTextarea>

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
      </PixBlock>
    </:main>
  </PixAppLayout>
</template>
