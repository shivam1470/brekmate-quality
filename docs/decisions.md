# Decisions and unresolved rules

## Confirmed
React Native + TypeScript customer app for Android/iOS only; React browser staff/admin/rider interfaces. One vegetarian café, multi-outlet-ready data model, not a marketplace. Pickup and delivery, configurable 2–3 km area, 1–2 manually assigned riders, order-status tracking and delivery OTP. AWS with OpenTofu, local-first tests and isolated staging. Never assume credits make production permanently free.

Delivery fee 2000 paise at subtotal <=9900; free strictly above. Pickup free. Rewards <=20% item subtotal and <=available balance; exclude taxes and delivery; rewards do not affect delivery threshold. Initial launch: COD and cash at pickup only. Prepaid/online payments are deferred. Referrer earns 10000 paise on referred customer's first qualifying order strictly above 9900, after delivery and payment collection. Cancelled/fully refunded orders do not qualify; no self-referral or duplicate reward. No wallet topups/withdrawals.

Celebration venue: separate premium first-floor space for approximately 15–20 guests; free with no minimum food spend. Basic complimentary decoration is introductory, with configurable dates/inclusions. Free camera, request self-use or assistance. Assistance pricing/availability unconfirmed. Manual email/WhatsApp photo delivery with chosen contact and consent. No marketing rights implied. Enquiry then staff confirmation, no instant reservation.

## Proposed / unresolved (never silently treat as approved)
- Floor fractional 20% reward allowances to whole paise; current pricing vectors use this proposal.
- Definition of subtotal when coupons are introduced; tax rates, tax inclusivity, receipts and discount sequencing.
- Empty cart/zero-value item policy, maximum quantities and maximum monetary values.
- Radius 2 or 3 km, straight-line vs routed measurement, exact boundary inclusion and geocoding provider.
- Authentication provider, OTP expiration, rate limits and staff session revocation policy.
- Cancellation eligibility, partial refunds, refund destination, referral reversal after spent rewards and whether later orders qualify after an unsuccessful first order.
- Inventory reservation duration/release rules and prepaid rejected-order reconciliation.
- Exact venue capacity, reservation durations/buffers, hours, no-show/cancellation policy, promotion dates/inclusions and assistance charges.
- Data retention/deletion policy, supported devices/OS, latency/load targets, availability objectives and recovery targets.
- Gateway, notifications and store account choices.

Cases referring to configured/approved policy are specification work, not claims that a policy or implementation exists. Resolve before those cases become executable release gates.
