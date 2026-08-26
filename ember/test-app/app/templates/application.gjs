import { PixAppLayout, PixNavigation, PixNavigationButton, PixBannerAlert } from '@1024pix/nebulix-ember';

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
          <PixNavigationButton href="/tests" @icon="bolt">Launch all tests</PixNavigationButton>
        </:navElements>
      </PixNavigation>
    </:navigation>
    <:main>
      {{outlet}}
    </:main>
  </PixAppLayout>
</template>
