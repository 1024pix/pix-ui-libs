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

function noop(event) {
  console.log('noop noop!');
}

<template>
  {{pageTitle "Demo App"}}

  <h1>Addon DEMO APP Nebulix !</h1>

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

</template>
