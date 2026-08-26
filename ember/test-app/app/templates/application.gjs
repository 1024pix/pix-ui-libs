import {
  PixAppLayout,
  PixBannerAlert,
  PixNavigation,
  PixNavigationButton,
} from '@1024pix/nebulix-ember';

<template>
  <PixAppLayout @variant="orga">
    <:banner>
      <PixBannerAlert @type="warning">
        WARNING ceci n'est pas un exercice | WARNING ceci n'est pas un exercice | WARNING ceci n'est
        pas un exercice | WARNING ceci n'est pas un exercice | WARNING ceci n'est pas un exercice |
        WARNING ceci n'est pas un exercice | WARNING ceci n'est pas un exercice | WARNING ceci n'est
        pas un exercice | WARNING ceci n'est pas un exercice | WARNING ceci n'est pas un exercice
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
            @route="button-page"
            @icon="lightBulb"
          >PixButton</PixNavigationButton>
        </:navElements>
      </PixNavigation>
    </:navigation>
    <:main>
      {{outlet}}
    </:main>
  </PixAppLayout>
</template>
