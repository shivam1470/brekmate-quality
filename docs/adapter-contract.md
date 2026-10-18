# Product adapter contract (proposal, not an existing backend API)

`BREKMATE_TEST_ADAPTER=/absolute/path/to/adapter.mjs npm run test:product`

The module must export `async quote(input)` and invoke actual BrekMate pricing code or a real isolated backend. Do not return the fixture expectations or copy the test oracle into an adapter.

Input: `{subtotalPaise, availableRewardPaise, fulfilment: "delivery"|"pickup", useRewards}`.
Output: `{subtotalPaise, deliveryFeePaise, rewardUsedPaise, totalPaise}` (all integer paise).

These inputs describe a tax-free, coupon-free controlled fixture. When testing through HTTP, the adapter must seed trusted menu prices, an authenticated customer's reward balance and a serviceable address in an isolated test environment, then request a server quote. They are NOT a suggested public endpoint accepting client-trusted subtotal or wallet balance. An in-process adapter can invoke a pure pricing service but does not prove authentication, inventory, persistence or HTTP integration.

Each call must be independent and reset its fixtures. Real provider calls are forbidden in this deterministic suite. No production URL, real money, real SMS or customer data. Configure an explicit staging allowlist before adding network drivers. Schema and endpoint contracts must be agreed with the backend developer; none have been guessed here.

The rounding-down rule for fractional reward paise is proposed and awaits approval. Until approved, affected vectors cannot become release evidence. Taxes, coupons and refund rules are excluded from these vectors and remain separate blocked work.
