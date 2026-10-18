# Generated from catalogue/scenarios; do not edit.
Feature: BM-MOBILE

  @BM-MOBILE-001 @P1
  Scenario: Android back
    Given Cart, checkout and modal are open in sequence
    When Use hardware/system back
    Then Navigation unwinds safely without accidental duplicate order

  @BM-MOBILE-002 @P1
  Scenario: iOS safe areas
    Given Notched iPhone in supported orientations
    When Visit primary screens
    Then Content and actionable controls remain accessible

  @BM-MOBILE-003 @P1
  Scenario: Keyboard checkout
    Given Small screen and address/contact keyboard visible
    When Enter details and submit
    Then Focused input and submit action remain reachable

  @BM-MOBILE-004 @P1
  Scenario: Restart cart
    Given Nonempty configured cart
    When Kill and reopen app
    Then Cart recovery follows documented policy with fresh availability checks

  @BM-MOBILE-005 @P1
  Scenario: Offline recovery
    Given Network drops during checkout submission
    When Reconnect and retry
    Then Server state is reconciled without duplicate order

  @BM-MOBILE-006 @P1
  Scenario: Accessibility
    Given Screen reader and large text enabled
    When Complete order journey
    Then Labels, focus, errors and totals are perceivable and usable

  @BM-MOBILE-007 @P1
  Scenario: Payment return
    Given External UPI application completes/cancels
    When Return through valid app link
    Then Correct pending order resumes and backend state is queried

  @BM-MOBILE-008 @P1
  Scenario: Malicious link
    Given Untrusted or altered deep link
    When Open app
    Then No arbitrary URL, token disclosure or unauthorised order operation

  @BM-MOBILE-009 @P1
  Scenario: Fresh install
    Given No prior local data or permissions
    When Launch production build
    Then Onboarding works without prototype role selector

  @BM-MOBILE-010 @P1
  Scenario: Upgrade
    Given Existing install with saved state
    When Install next compatible version
    Then Session/cart migration handles supported old state safely
