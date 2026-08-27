import { setApplication } from '@ember/test-helpers';
import Application from 'docs-app/app';
import { start as qunitStart } from 'ember-qunit';
import * as QUnit from 'qunit';
import { setup } from 'qunit-dom';

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
