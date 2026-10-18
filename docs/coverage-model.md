# Coverage model and count semantics
158 authored logical scenarios span 15 requirement areas. 36,864 generated controlled basket combinations expand eight breakfast prices, eight beverage prices, three quantities for each line, four breakfast add-on prices, four reward-balance boundaries, two fulfilment modes and reward on/off: 8*8*3*3*4*4*2*2. The baskets test two-line summation, per-unit add-on multiplication, redemption caps and delivery calculation. They are NOT 36,864 unique end-to-end customer journeys or evidence that every feature has that depth.

The 432 legacy pricing vectors include exact 9899/9900/9901-paise delivery boundaries and non-round paise. Legacy fractional reward rounding is proposed; generated baskets use whole-rupee inputs, so they do not extend rounding-policy authority. An identical numeric outcome from different fixture baskets can still expose line-item implementation defects; exact generated inputs are deduplicated.

Count independently: logical scenarios; expanded examples; property-based trials (none yet); platform variants; execution attempts; verified passes. Never add dataset copies, assertion counts, retries or reruns to the case count. all-baskets.jsonl, if exported, duplicates shard data and is not another dataset.

Coverage gaps: real auth/storage/API contracts, native/browser flows, provider wiring, IAM, performance/recovery evidence and resolved policies. JSON catalogue mapping is at requirement-area granularity, not a complete fine-grained requirements audit. 30k+ combinations cannot guarantee no missing scenario.
