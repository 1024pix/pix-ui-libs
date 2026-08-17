import { pageTitle } from 'ember-page-title';
import Block from "@1024pix/nebulix-ember/block";

const greeting = 'hello';

<template>
  {{pageTitle "Demo App"}}

  <h1>Welcome to ember!</h1>

  <Block />

  {{greeting}}, world!
</template>
