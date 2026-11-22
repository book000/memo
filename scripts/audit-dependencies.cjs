const { createHash } = require('node:crypto');
const { readFileSync, realpathSync } = require('node:fs');
const { createRequire } = require('node:module');
const { spawnSync } = require('node:child_process');

const advisoryId = 'GHSA-hpmr-g4pq-jhgp';
const dependencyPath = '.>textlint-rule-date-weekday-mismatch>chrono-node';
const patchHash = '297f7bff5ed148ae96bfab4c491f08eccb8af5ff6439437f13d0dcce1bbdaa71';

function isPatchedFinding(advisory) {
  return advisory.github_advisory_id === advisoryId &&
    advisory.module_name === 'chrono-node' &&
    Array.isArray(advisory.findings) && advisory.findings.length > 0 &&
    advisory.findings.every(finding => finding.version === '1.4.9' &&
      Array.isArray(finding.paths) && finding.paths.length > 0 &&
      finding.paths.every(path => path === dependencyPath));
}

function hasInstalledPatch() {
  const patch = readFileSync('patches/chrono-node@1.4.9.patch');
  const hash = createHash('sha256').update(patch).digest('hex');
  const ruleRequire = createRequire(require.resolve('textlint-rule-date-weekday-mismatch'));
  const installedPath = realpathSync(ruleRequire.resolve('chrono-node'));
  return hash === patchHash && installedPath.includes(`chrono-node@1.4.9_patch_hash=${patchHash}`);
}

function main() {
  const result = spawnSync('pnpm', ['audit', '--json'], { encoding: 'utf8' });
  if (result.error || ![0, 1].includes(result.status)) throw new Error('Dependency audit failed to run');
  const report = JSON.parse(result.stdout);
  if (!report.advisories || !report.metadata || !report.metadata.vulnerabilities) throw new Error('Invalid audit report');
  const findings = Object.values(report.advisories);
  if (result.status === 0 && findings.length === 0) return;
  if (findings.length !== 1 || !isPatchedFinding(findings[0]) || !hasInstalledPatch()) {
    process.stderr.write(result.stdout);
    throw new Error('Dependency audit found unaddressed advisories');
  }
  process.stdout.write(`Patched advisory ${advisoryId}: ${dependencyPath}\n`);
}

if (require.main === module) {
  try {
    main();
  } catch (error) {
    process.stderr.write(`${error.message}\n`);
    process.exitCode = 1;
  }
}

module.exports = { isPatchedFinding, hasInstalledPatch };
