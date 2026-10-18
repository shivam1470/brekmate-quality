import {readFileSync,readdirSync,mkdirSync,writeFileSync,rmSync} from 'node:fs';
import {baskets} from '../data/generators/baskets.mjs';
const root=new URL('../',import.meta.url);
const read=p=>JSON.parse(readFileSync(new URL(p,root)));
const cases=readdirSync(new URL('catalogue/scenarios/',root)).filter(x=>x.endsWith('.json')).sort().flatMap(x=>read('catalogue/scenarios/'+x));
mkdirSync(new URL('generated/',root),{recursive:true});
const csvRow=a=>a.map(v=>`"${String(v).replaceAll('"','""')}"`).join(',');
writeFileSync(new URL('generated/catalogue.csv',root),[csvRow(['id','requirement','title','priority','given','when','then','automationStatus']),...cases.map(c=>csvRow([c.id,c.requirement,c.title,c.priority,c.given,c.when,c.then,c.automationStatus]))].join('\n')+'\n');
const seen=new Set(), seenInputs=new Set();let rows=[],index=[],count=0,shard=0;
const flush=()=>{if(!rows.length)return;const file=`baskets-${String(shard++).padStart(3,'0')}.jsonl`;writeFileSync(new URL('generated/'+file,root),rows.join('\n')+'\n');index.push({file,count:rows.length});rows=[];};
for(const c of baskets()) {
 const key=JSON.stringify(c.input);
 if(seen.has(c.id)||seenInputs.has(key))throw Error('Duplicate generated case '+c.id);
 seen.add(c.id);seenInputs.add(key);rows.push(JSON.stringify(c));count++;
 if(rows.length===4096)flush();
}
flush();
const keep=new Set(index.map(x=>x.file));
for(const f of readdirSync(new URL('generated/',root))) if(/^baskets-\d+\.jsonl$/.test(f)&&!keep.has(f))rmSync(new URL('generated/'+f,root));
writeFileSync(new URL('generated/index.json',root),JSON.stringify({version:1,logicalScenarios:cases.length,expandedBasketCases:count,legacyPricingVectors:read('fixtures/pricing.json').length,shards:index,productExecutions:0},null,2)+'\n');
// Gherkin is a generated readable view, not an executable Cucumber suite.
for(const area of new Set(cases.map(c=>c.requirement))) {
 const selected=cases.filter(c=>c.requirement===area);
 writeFileSync(new URL('features/'+area.slice(3).toLowerCase()+'.feature',root),'# Generated from catalogue/scenarios; do not edit.\nFeature: '+area+'\n\n'+selected.map(c=>`  @${c.id} @${c.priority}\n  Scenario: ${c.title}\n    Given ${c.given}\n    When ${c.when}\n    Then ${c.then}\n`).join('\n'));
}
console.log(JSON.stringify({logicalScenarios:cases.length,expandedBasketCases:count,shards:index.length}));
