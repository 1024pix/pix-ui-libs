import { pageTitle } from 'ember-page-title';
import PixBlock from "../../src/layout/pix-block.gjs";
import PixIcon from "../../src/graphics/pix-icon.gjs";

<template>
  {{pageTitle "Demo App"}}

  <h1>Addon DEMO APP Nebulix !</h1>

  <PixBlock>
    <PixIcon @name="brick" @plainIcon="true"/>
      Coucou c'est nous !
  </PixBlock>
</template>
