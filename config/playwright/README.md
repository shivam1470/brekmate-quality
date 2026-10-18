# Playwright configuration contract
Pin @playwright/test when a real staff web/API target is available. Separate projects for cafe, admin and rider interfaces; browser/device projects describe execution variants, not unique business cases. Use per-worker accounts, API seed fixtures, isolated contexts and stable accessible selectors from actual code. Record traces on failure with redaction. Derive baseURL from an explicit local/staging allowlist and reject production URLs before setup.

No runnable web config or guessed selectors are claimed in this milestone because app source/build endpoints are unavailable. Add a validated playwright.config.ts with testMatch scoped to web/API tests; never discover Node contract tests or native flows through Playwright.
