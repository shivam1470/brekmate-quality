# Generated from catalogue/scenarios; do not edit.
Feature: BM-REF

  @BM-REF-001 @P0
  Scenario: Qualifying prepaid referral
    Given New referred customer first order exceeds 9900 and is paid
    When Mark delivered
    Then Referrer receives exactly 10000 paise once

  @BM-REF-002 @P0
  Scenario: Referral exact threshold
    Given First delivered paid order subtotal is 9900
    When Evaluate referral
    Then No reward is credited

  @BM-REF-003 @P0
  Scenario: Referral below threshold
    Given First delivered paid order subtotal is 9899
    When Evaluate referral
    Then No reward is credited

  @BM-REF-004 @P0
  Scenario: Uncollected COD referral
    Given Qualifying referred order delivered but cash not collected
    When Evaluate referral
    Then No reward until collection is confirmed

  @BM-REF-005 @P0
  Scenario: Collected COD referral
    Given Qualifying COD delivery and collection confirmed
    When Evaluate referral twice
    Then One 10000-paise credit occurs

  @BM-REF-006 @P0
  Scenario: Undelivered order
    Given Referred first order is paid but preparing
    When Evaluate referral
    Then Reward remains uncredited

  @BM-REF-007 @P0
  Scenario: Cancelled first order
    Given Referred order is cancelled
    When Evaluate referral
    Then No reward for that cancelled order

  @BM-REF-008 @P0
  Scenario: Fully refunded order
    Given A qualifying order is fully refunded
    When Reconcile referral under approved reversal policy
    Then No retained qualifying reward; reversal and debt policy must be explicit

  @BM-REF-009 @P0
  Scenario: Self referral
    Given Customer enters own referral code
    When Attempt referral registration
    Then Self-referral is rejected

  @BM-REF-010 @P0
  Scenario: Invalid code
    Given A nonexistent referral code
    When Apply code
    Then Clear invalid-code response without creating attribution

  @BM-REF-011 @P0
  Scenario: Second order
    Given Customer already has a qualifying first-order reward
    When Deliver another order
    Then No new first-order reward

  @BM-REF-012 @P0
  Scenario: Duplicate delivery events
    Given One qualifying referral order
    When Process delivery events concurrently
    Then Exactly one unique reward ledger entry
