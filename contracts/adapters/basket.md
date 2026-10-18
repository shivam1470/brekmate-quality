# Isolated basket adapter — proposal

Export `async quoteBasket(input)` from a module selected by BREKMATE_BASKET_ADAPTER. Input has controlled fixture `lines` (sku, unitPricePaise, quantity, addOnPaise), reward balance, fulfilment and reward toggle. Output: integer subtotalPaise, deliveryFeePaise, rewardUsedPaise, totalPaise.

Invoke the actual application's basket/pricing service. For an HTTP integration, seed these catalogue prices, permitted add-ons and the customer's ledger in an isolated environment, then request a server-priced quote by SKU/quantity/configuration. NEVER send fixture prices or balance as trusted customer values to a public endpoint. Reset/isolate fixture data for each call.

The oracle is in the test generator; do not import it into the adapter or return generated expected values. Use no real gateway/SMS/WhatsApp calls. This suite is tax-free and coupon-free. It proves arithmetic/fixture behaviour only, not full native E2E. Max quantities and real product/add-on combinations require actual configured catalogue tests as well.

The original 432 quote vectors remain separate and use BREKMATE_TEST_ADAPTER. Generated basket cases add quantities/add-on arithmetic to that narrower pricing contract. Shared outcomes are intentional cross-layer checks, not new logical requirements. Sharding: SHARD_INDEX is zero-based and less than SHARD_TOTAL; collect evidence from every shard before marking the set complete.
