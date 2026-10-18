import {test} from 'node:test';
import assert from 'node:assert/strict';
import {resolve} from 'node:path';
import {pathToFileURL} from 'node:url';
import {baskets} from '../data/generators/baskets.mjs';
const path=process.env.BREKMATE_BASKET_ADAPTER;
if(!path) {
 test('BLOCKED: basket adapter must invoke real isolated product code',()=>assert.fail('36,864 expanded combinations are not product executions. Set BREKMATE_BASKET_ADAPTER; see contracts/adapters/basket.md.'));
} else {
 const {quoteBasket}=await import(pathToFileURL(resolve(path)).href);
 assert.equal(typeof quoteBasket,'function');
 const shard=Number(process.env.SHARD_INDEX??0),total=Number(process.env.SHARD_TOTAL??1);
 assert(Number.isInteger(total)&&total>0&&Number.isInteger(shard)&&shard>=0&&shard<total,'Invalid shard configuration');
 let n=0;
 for(const c of baskets()) {
  if(n++%total!==shard)continue;
  test(c.id,{timeout:15000},async()=>{
   const actual=await quoteBasket(structuredClone(c.input));
   for(const [k,v] of Object.entries(c.expected)){assert(Number.isSafeInteger(actual?.[k]),k);assert.equal(actual[k],v,k);}
  });
 }
}
