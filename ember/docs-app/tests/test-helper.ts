import { setApplication } from '@ember/test-helpers';
import { start as qunitStart } from 'ember-qunit';
import * as QUnit from 'qunit';
import { setup } from 'qunit-dom';

import Application from 'docs-app/app';

export function start(): void {
  setApplication(
    Application.create({
      autoboot: false,
      rootElement: '#ember-testing',
    }),
  );

  setup(QUnit.assert);

  qunitStart();
}
