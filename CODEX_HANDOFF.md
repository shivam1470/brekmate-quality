# Local Codex handoff
Inspect this workspace and applicable AGENTS.md. Use README.md and docs/execution-guide.md. Preserve existing application work. Authoritative scenarios are under catalogue/scenarios. Regenerate derived files before running integrity checks.

Do not assume these files are already in GitHub; prior connector writes were denied with 403. The verified remote branch was chatgpt-tc. Local Git changes require reviewing existing status and paths.

Connect real isolated pricing/basket adapters using contracts/adapters/basket.md and docs/adapter-contract.md. Observe meaningful failing business assertions before implementing feature logic; absent-adapter errors are configuration blockers only. Then expand actual API, web and native drivers against real contracts/selectors. Never return fixture oracles from an adapter.

Do not implement 36k UI flows. The large dataset belongs to fast basket/pricing layers. Keep critical native/web end-to-end paths separate. Publish run evidence with exact application/test commits and preserve blocked cases.
