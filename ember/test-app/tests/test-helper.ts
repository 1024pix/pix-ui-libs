import Application from 'test-app/app';
import config from 'test-app/config/environment';
import * as QUnit from 'qunit';
import { setApplication, getRootElement } from '@ember/test-helpers';
import { setup } from 'qunit-dom';
import { start as qunitStart } from 'ember-qunit';

/**
 * Asserts that the rendered output contains the given text, matching the
 * assertion the Pix UI test suites are written against.
 */
function setupContainsAssertion(assert: Assert): void {
  assert.contains = function (expected: string, message?: string) {
    const actual = getRootElement().textContent ?? '';

    this.pushResult({
      result: actual.includes(expected),
      actual,
      expected,
      message:
        message ?? `Expected the rendered output to contain "${expected}"`,
    });
  };
}

export function start() {
  setApplication(Application.create(config.APP));

  setup(QUnit.assert);
  setupContainsAssertion(QUnit.assert);

  qunitStart();
}
