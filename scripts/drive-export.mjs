import {readFileSync,writeFileSync} from 'node:fs';
const root=new URL('../',import.meta.url);
const index=JSON.parse(readFileSync(new URL('generated/index.json',root)));
writeFileSync(new URL('generated/all-baskets.jsonl',root),index.shards.map(s=>readFileSync(new URL('generated/'+s.file,root),'utf8')).join(''));
console.log('Created consolidated portable dataset; content duplicates shards and must not be counted twice.');
