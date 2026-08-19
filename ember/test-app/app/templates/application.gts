import { pageTitle } from 'ember-page-title';

import { PixBlock } from '@1024pix/nebulix-ember';

<template>
  {{pageTitle "TestApp"}}

  <h1>Welcome to TestApp</h1>

  <PixBlock>Hello world</PixBlock>

  <a href="/tests">Launch all tests</a>

  {{outlet}}
</template>
