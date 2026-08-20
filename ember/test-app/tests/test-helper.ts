import Application from 'test-app/app';
import config from 'test-app/config/environment';
import * as QUnit from 'qunit';
import { setApplication } from '@ember/test-helpers';
import { setup } from 'qunit-dom';
import { start as qunitStart } from 'ember-qunit';

import { contains } from './helpers/contains';

export function start() {
  setApplication(Application.create(config.APP));

  QUnit.assert.contains = contains;

  setup(QUnit.assert);

  qunitStart();
}
