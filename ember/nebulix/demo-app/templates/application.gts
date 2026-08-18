import { pageTitle } from 'ember-page-title';

import PixBlock from "../../src/layout/pix-block.gjs";
import PixIcon from "../../src/graphics/pix-icon.gjs";
import PixButton from "../../src/actions/pix-button.gjs";
import PixButtonLink from "../../src/actions/pix-button-link.gjs";
import PixButtonUpload from "../../src/actions/pix-button-upload.gjs";

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


</template>
