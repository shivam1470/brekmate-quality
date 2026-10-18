import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { existsSync } from 'node:fs';
const root = fileURLToPath(new URL('../', import.meta.url));
const backend = fileURLToPath(new URL('../../brekmate-be/', import.meta.url));
const adapter = fileURLToPath(new URL('../../brekmate-be/adapters/quality.mjs', import.meta.url));
if (!existsSync(adapter)) throw new Error('Sibling brekmate-be source and dependencies are required.');
for (const [cwd, args, env] of [
  [backend, ['run', 'build'], process.env],
  [root, ['test'], { ...process.env, BREKMATE_TEST_ADAPTER: adapter, BREKMATE_BASKET_ADAPTER: adapter }],
]) {
  const result = spawnSync('npm', args, { cwd, env, stdio: 'inherit' });
  if (result.error) throw result.error;
  if (result.status !== 0) process.exit(result.status ?? 1);
}
