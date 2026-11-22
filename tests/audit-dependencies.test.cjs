const assert = require('node:assert/strict');
const test = require('node:test');
const { isPatchedFinding, hasInstalledPatch } = require('../scripts/audit-dependencies.cjs');

const finding = {
  github_advisory_id: 'GHSA-hpmr-g4pq-jhgp',
  module_name: 'chrono-node',
  findings: [{ version: '1.4.9', paths: ['.>textlint-rule-date-weekday-mismatch>chrono-node'] }],
};

test('recognizes only the patched dependency path and version', () => {
  assert.equal(hasInstalledPatch(), true);
  assert.equal(isPatchedFinding(finding), true);
  assert.equal(isPatchedFinding({ ...finding, github_advisory_id: 'GHSA-other' }), false);
  assert.equal(isPatchedFinding({ ...finding, findings: [{ version: '1.4.8', paths: finding.findings[0].paths }] }), false);
  assert.equal(isPatchedFinding({ ...finding, findings: [{ version: '1.4.9', paths: [...finding.findings[0].paths, '.>other>chrono-node'] }] }), false);
});
