import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync,readdirSync} from 'node:fs';
import {baskets} from '../data/generators/baskets.mjs';
import {validate} from '../scripts/schema-validator.mjs';
const root=new URL('../',import.meta.url);
const read=p=>JSON.parse(readFileSync(new URL(p,root)));
test('all scenarios satisfy the checked schema subset',()=>{
 const schema=read('catalogue/schemas/scenario.schema.json');
 for(const f of readdirSync(new URL('catalogue/scenarios/',root))) if(f.endsWith('.json')) for(const c of read('catalogue/scenarios/'+f)) validate(schema,c);
});
test('schema rejects incomplete, unknown-field and invalid-type records',()=>{
 const schema=read('catalogue/schemas/scenario.schema.json');
 const c=read('catalogue/scenarios/auth.json')[0];
 const missing={...c};delete missing.then;assert.throws(()=>validate(schema,missing));
 assert.throws(()=>validate(schema,{...c,priority:'P9'}));
 assert.throws(()=>validate(schema,{...c,title:''}));
 assert.throws(()=>validate(schema,{...c,blocking_decision:'false'}));
 assert.throws(()=>validate(schema,{...c,unknown:true}));
 assert.throws(()=>validate({type:'string',unsupported:true},'x'));
});
test('evidence schema keeps execution separate and rejects unspecified outcomes',()=>{
 const schema=read('catalogue/schemas/evidence.schema.json');
 const record={runId:'run-test',testCommit:'fixture',environment:'local-validation',startedAt:'2026-10-18T00:00:00Z',finishedAt:'2026-10-18T00:00:01Z',applicationCommits:{},dependencyModes:{},results:[{caseId:'harness-test',outcome:'passed',attempt:1,platform:'node',artifacts:[]}]};
 validate(schema,record);record.results[0].outcome='assumed-pass';assert.throws(()=>validate(schema,record));
});
test('basket generator independently hand-calculated examples',()=>{
 const rows=[...baskets()];
 // 1x20 breakfast + 1x10 beverage =30; reward cap6, delivery20, total44.
 const small=rows.find(c=>c.id==='BM-BASKET-a0-b0-qa1-qb1-x0-cap-delivery-on');
 assert.deepEqual(small.expected,{subtotalPaise:3000,deliveryFeePaise:2000,rewardUsedPaise:600,totalPaise:4400});
 // 2x(49+10) + 5x20 =218; cap43.60, pickup free, total174.40.
 const mixed=rows.find(c=>c.id==='BM-BASKET-a2-b1-qa2-qb5-x1000-cap-pickup-on');
 assert.deepEqual(mixed.expected,{subtotalPaise:21800,deliveryFeePaise:0,rewardUsedPaise:4360,totalPaise:17440});
 const off=rows.find(c=>c.id==='BM-BASKET-a0-b0-qa1-qb1-x0-cap-delivery-off');
 assert.deepEqual(off.expected,{subtotalPaise:3000,deliveryFeePaise:2000,rewardUsedPaise:0,totalPaise:5000});
});
test('unique reproducible combinations preserve invariants and count semantics',()=>{
 const ids=new Set(),inputs=new Set();let count=0;
 for(const c of baskets()){
  assert(!ids.has(c.id));ids.add(c.id);
  const key=JSON.stringify(c.input);assert(!inputs.has(key));inputs.add(key);
  for(const n of Object.values(c.expected)) assert(Number.isSafeInteger(n)&&n>=0);
  assert(c.expected.rewardUsedPaise<=c.input.availableRewardPaise);
  assert(c.expected.rewardUsedPaise*5<=c.expected.subtotalPaise);
  assert.equal(c.expected.totalPaise,c.expected.subtotalPaise+c.expected.deliveryFeePaise-c.expected.rewardUsedPaise);
  assert.equal(c.status,'generated-not-executed');count++;
 }
 assert.equal(count,36864); // derived model cardinality, not a target-driven loop
 assert.equal([...baskets()][0].id,[...baskets()][0].id);
 const index=read('generated/index.json');assert.equal(index.expandedBasketCases,count);
});
