// Minimal validator for the explicit subset used by this repository's schemas.
// It is NOT a general-purpose Draft 2020-12 implementation. Unsupported keywords fail closed.
import assert from 'node:assert/strict';
const supported = new Set(['$schema','type','required','properties','additionalProperties','items','enum','minLength','minItems','minimum']);
export function validate(schema, value, at='$') {
 for (const k of Object.keys(schema)) assert(supported.has(k), `Unsupported schema keyword ${k}`);
 const isObject = value !== null && typeof value === 'object' && !Array.isArray(value);
 const type = schema.type;
 const valid = type === 'object' ? isObject : type === 'array' ? Array.isArray(value) : type === 'integer' ? Number.isSafeInteger(value) : typeof value === type;
 assert(valid, `${at}: expected ${type}`);
 if (schema.enum) assert(schema.enum.includes(value), `${at}: enum`);
 if (schema.minLength !== undefined) assert(value.length >= schema.minLength, `${at}: minLength`);
 if (schema.minimum !== undefined) assert(value >= schema.minimum, `${at}: minimum`);
 if (type === 'array') {
  if(schema.minItems !== undefined) assert(value.length >= schema.minItems, `${at}: minItems`);
  if(schema.items) value.forEach((v,i)=>validate(schema.items,v,`${at}[${i}]`));
 }
 if (type === 'object') {
  for(const k of schema.required ?? []) assert(Object.hasOwn(value,k),`${at}: missing ${k}`);
  for(const [k,v] of Object.entries(value)) {
   if(schema.properties?.[k]) validate(schema.properties[k],v,`${at}.${k}`);
   else if(schema.additionalProperties === false) assert.fail(`${at}: unexpected ${k}`);
   else if(typeof schema.additionalProperties === 'object') validate(schema.additionalProperties,v,`${at}.${k}`);
  }
 }
 return true;
}
