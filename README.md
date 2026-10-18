# BrekMate quality workspace
Start with docs/execution-guide.md. This is a test specification, generator and contract-harness foundation, NOT a verified full end-to-end suite.

- Authoritative: catalogue/scenarios domain JSON and docs/confirmed-requirements.md.
- 158 authored scenarios / 15 requirement areas.
- 36,864 generated basket combinations plus 432 legacy pricing vectors; not unique UI journeys.
- Current product executions: ZERO. Native/web/provider drivers still required.
- Run `npm run generate`, then `npm run test:catalogue`.
- `npm run test:product` and `npm run readiness` intentionally fail while product adapters/evidence are absent.
- Read docs/decisions.md before implementing unresolved policy.

Folder copy maintained in Google Drive on request. No automatic Mac/GitHub/background sync. Do not edit generated views; edit models/catalogue and regenerate.

## Coordinated review — 18 October 2026

Current findings, checks and release blockers: [release review](docs/release-2026-10-18/RELEASE_CHECKLIST.md). This review supersedes historical passing counts; no deployment or production approval is granted.
