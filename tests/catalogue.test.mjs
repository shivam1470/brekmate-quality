import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync,readdirSync} from 'node:fs';
const read = p => JSON.parse(readFileSync(new URL(p, import.meta.url)));
const scenarios = readdirSync(new URL('../catalogue/scenarios/',import.meta.url)).filter(x=>x.endsWith('.json')).flatMap(x=>read('../catalogue/scenarios/'+x));
const requirements = read('../catalogue/requirements/areas.json');
const vectors = read('../fixtures/pricing.json');
test('all catalogue IDs are unique and requirements resolve', () => {
  const ids = [...scenarios, ...vectors].map(x => x.id);
  assert.equal(new Set(ids).size, ids.length);
  const known = new Set(requirements.map(x => x.id));
  for (const c of scenarios) {
    assert(known.has(c.requirement), c.id);
    for (const key of ['given','when','then']) assert(c[key]?.trim(), `${c.id}: ${key}`);
    assert.equal(c.status, 'specified');
  }
  for (const v of vectors) for (const r of v.requirements) assert(known.has(r));
});
test('every requirement has at least one acceptance scenario', () => {
  for (const r of requirements) assert(scenarios.some(c => c.requirement === r.id), r.id);
});
test('fixture shape uses integer paise and unique input combinations', () => {
  const seen = new Set();
  for (const v of vectors) {
    const key = JSON.stringify(v.input); assert(!seen.has(key)); seen.add(key);
    for (const n of Object.values(v.expected)) assert(Number.isSafeInteger(n) && n >= 0);
    assert.equal(v.expected.totalPaise, v.expected.subtotalPaise + v.expected.deliveryFeePaise - v.expected.rewardUsedPaise);
    assert(v.expected.rewardUsedPaise <= v.input.availableRewardPaise);
    assert(v.expected.rewardUsedPaise * 5 <= v.input.subtotalPaise);
  }
});
test('critical exact-threshold and pickup oracles are explicit', () => {
  for (const subtotal of [9899,9900,9901]) {
    const v = vectors.find(v => v.input.subtotalPaise === subtotal && v.input.fulfilment === 'delivery' && !v.input.useRewards);
    assert(v); assert.equal(v.expected.deliveryFeePaise, subtotal > 9900 ? 0 : 2000);
  }
  for (const v of vectors.filter(v => v.input.fulfilment === 'pickup')) assert.equal(v.expected.deliveryFeePaise, 0);
});
