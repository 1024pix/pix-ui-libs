import { setApplication } from '@ember/test-helpers';
import { start as qunitStart } from 'ember-qunit';
import * as QUnit from 'qunit';
import { setup } from 'qunit-dom';
import Application from 'test-app/app';
import config from 'test-app/config/environment';

import { contains } from './helpers/contains';

export function start() {
  setApplication(Application.create(config.APP));

  QUnit.assert.contains = contains;

  setup(QUnit.assert);

  qunitStart();
}
