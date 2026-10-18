import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {resolve} from 'node:path';
import {pathToFileURL} from 'node:url';
const vectors = JSON.parse(readFileSync(new URL('../fixtures/pricing.json', import.meta.url)));
const adapterPath = process.env.BREKMATE_TEST_ADAPTER;
if (!adapterPath) {
  test('BLOCKED: real BrekMate pricing adapter must be connected', () => {
    assert.fail(`${vectors.length} pricing vectors are NOT executed. Set BREKMATE_TEST_ADAPTER to an absolute module path implementing quote(input). See docs/adapter-contract.md. No mock pass is permitted.`);
  });
} else {
  const adapter = await import(pathToFileURL(resolve(adapterPath)).href);
  assert.equal(typeof adapter.quote, 'function', 'Adapter must export quote(input)');
  for (const vector of vectors) {
    test(vector.id + ' ' + JSON.stringify(vector.input), {timeout:15000}, async () => {
      const result = await adapter.quote(structuredClone(vector.input));
      assert(result && typeof result === 'object', 'Missing quote result');
      for (const [key,value] of Object.entries(vector.expected)) {
        assert(Number.isSafeInteger(result[key]), `${key} must be integer paise`);
        assert.equal(result[key], value, key);
      }
    });
  }
}
