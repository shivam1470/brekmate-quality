import {readFileSync} from 'node:fs';
const root=new URL('../',import.meta.url);
const index=JSON.parse(readFileSync(new URL('generated/index.json',root)));
console.log(JSON.stringify({releaseReady:false,...index,executedAgainstProduct:0,blockers:['Actual application build/commits and adapters unavailable','Native and browser drivers unimplemented','Cloud/provider/security/recovery/load execution absent','Unresolved policies in docs/decisions.md'],harnessPassesAreNotProductPasses:true},null,2));process.exitCode=1;
