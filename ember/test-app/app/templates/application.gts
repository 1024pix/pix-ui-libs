import { PixAppLayout, PixButtonLink, PixNavigationButton, PixNavigation } from '@1024pix/nebulix-ember';

<template>
  <PixAppLayout>
    <:navigation>
      <PixNavigation>
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
