# End-to-end execution plan

1. Agree contracts with backend and get build/commit identifiers for all four applications. Keep unit tests with implementation; this repo owns system acceptance and cross-application verification.
2. Connect the pricing adapter and observe real red results before implementation; then implement rules and obtain green results. Never use fixture-oracle adapters as product evidence.
3. Add isolated database fixtures and API clients for authentication, menu, orders, payments, ledger, referrals, delivery and reservations. Test transactions/races using concurrent requests and verified persisted effects.
4. Add Playwright for café/admin/rider web and API journeys. Pin dependencies and obtain app selectors/URLs from real code. Do not use Playwright as proof of native React Native UI behaviour.
5. Add a native tool (evaluate Maestro or Detox against the actual RN build) for Android/iPhone. Real scenarios must include customer order -> staff acceptance -> rider -> customer delivery state, plus pickup, failed payments, rewards and celebrations.
6. Add gateway sandbox webhooks, payment app return, notifications, actual AWS IAM/event wiring, recovery and agreed performance/security checks. Synthetic fixtures only.
7. CI on each change: catalogue validation and appropriate fast checks. Product readiness is separate and remains blocked until mandatory evidence is complete. Reports must identify commits, platform/device, fixtures and real vs stubbed integrations. Keep pending/blocked cases in the denominator; no green badges for skipped launch features.

## Priority journeys
- UPI delivery >99 -> operator accepts/prepares -> assigned rider -> valid delivery OTP -> authoritative delivered state.
- COD referred first order >99 -> delivery without collection (no reward) -> collection -> one reward despite event replay.
- Exactly 99 delivery -> 20 fee -> apply capped reward -> payment receipt matches quote.
- Pickup below 99 -> zero delivery fee -> ready -> pickup completion without rider.
- Last stock unit raced by two customers -> one successful reservation, no double wallet debit.
- Gateway success after app timeout -> reconciliation recovers one paid order.
- Sold-out item or price change during checkout -> user recovery without hidden charge.
- Two staff confirm overlapping venue requests -> one confirmation; no venue charge/minimum spend.
- Expired decoration offer -> no stale complimentary promise; free camera and chosen photo channel retained.
- Other-customer/rider IDs and forged roles -> consistent denied access.

Feature files are readable acceptance specifications, NOT wired Cucumber tests. Browser/native runners, CI provider workflows and endpoint contracts are deliberately not fabricated before actual apps are available.
