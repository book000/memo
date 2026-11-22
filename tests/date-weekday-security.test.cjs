const assert = require('node:assert/strict');
const { spawnSync } = require('node:child_process');
const { createRequire } = require('node:module');
const test = require('node:test');

const ruleRequire = createRequire(require.resolve('textlint-rule-date-weekday-mismatch'));
const chrono = ruleRequire('chrono-node');

function lint(text) {
  return spawnSync(process.execPath, [require.resolve('textlint/bin/textlint.js'), '--no-textlintrc', '--rule', 'date-weekday-mismatch', '--stdin', '--stdin-filename', 'sample.md'], {
    input: text,
    encoding: 'utf8',
    timeout: 10000,
  });
}

test('bounds whitespace in relative time-unit parsing', () => {
  assert.equal(chrono.parse('1 day ago')[0].text, '1 day ago');
  assert.notEqual(chrono.parse('1 day      ago')[0].text, '1 day      ago');
});

test('finishes parsing the upstream whitespace regression input', () => {
  const source = `const {createRequire} = require('node:module');
    const chrono = createRequire(require.resolve('textlint-rule-date-weekday-mismatch'))('chrono-node');
    const text = 'BGR3' + ' '.repeat(90) + '186' + ' '.repeat(50) + 'days' + ' '.repeat(250) + '18' + ' '.repeat(50) + 'hours' + ' '.repeat(250) + '37' + ' '.repeat(50) + 'minutes' + ' '.repeat(250) + '01' + ' '.repeat(10) + 'seconds';
    chrono.parse(text);`;
  const result = spawnSync(process.execPath, ['-e', source], { timeout: 5000, encoding: 'utf8' });
  assert.ifError(result.error);
  assert.equal(result.status, 0, result.stderr);
});

test('handles long whitespace without losing later date offsets', () => {
  const source = `const assert = require('node:assert/strict');
    const {createRequire} = require('node:module');
    const chrono = createRequire(require.resolve('textlint-rule-date-weekday-mismatch'))('chrono-node');
    const text = '1 day' + ' '.repeat(100000) + '2024年4月23日';
    const result = chrono.parse(text).find(item => item.text === '2024年4月23日');
    assert.equal(result.index, 100005);`;
  const result = spawnSync(process.execPath, ['-e', source], { timeout: 5000, encoding: 'utf8' });
  assert.ifError(result.error);
  assert.equal(result.status, 0, result.stderr);
});

test('checks Japanese and English date weekdays', () => {
  for (const [text, expected] of [
    ['2024年4月23日(火)', 0],
    ['2024年4月23日(水)', 1],
    ['April 23, 2024 (Tuesday)', 0],
    ['April 23, 2024 (Wednesday)', 1],
  ]) {
    const result = lint(text);
    assert.ifError(result.error);
    assert.equal(result.status, expected, result.stdout + result.stderr);
    if (expected === 1) assert.match(result.stdout, /mismatch weekday/);
  }
});
