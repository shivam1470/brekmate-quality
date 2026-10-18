# Generated from catalogue/scenarios; do not edit.
Feature: BM-ORDER

  @BM-ORDER-001 @P0
  Scenario: Delivery order
    Given Valid cart, address and payment method
    When Place order
    Then One order with immutable line-price snapshots is created

  @BM-ORDER-002 @P0
  Scenario: Idempotent submit
    Given One checkout idempotency key
    When Retry the same request after timeout
    Then The original order is returned without duplicate debit

  @BM-ORDER-003 @P0
  Scenario: Conflicting retry
    Given Same idempotency key but different payload
    When Submit the changed request
    Then Conflict is rejected; original order is preserved

  @BM-ORDER-004 @P0
  Scenario: Last item race
    Given One remaining stock unit and two customers
    When Place orders concurrently
    Then At most one order reserves that unit

  @BM-ORDER-005 @P0
  Scenario: Insufficient stock
    Given Requested quantity exceeds stock
    When Place order
    Then No negative stock or partial undocumented charge occurs

  @BM-ORDER-006 @P0
  Scenario: Reject reason
    Given An operator rejects a new order
    When Submit without then with a reason
    Then Required reason is validated and rejection is recorded

  @BM-ORDER-007 @P0
  Scenario: Valid preparation
    Given Accepted order
    When Move through preparing and ready
    Then Customer sees valid transitions with timestamps

  @BM-ORDER-008 @P0
  Scenario: Illegal transition
    Given A newly placed order
    When Attempt to jump directly to delivered
    Then Transition is denied without changing order

  @BM-ORDER-009 @P0
  Scenario: Pickup completion
    Given Pickup order marked ready
    When Confirm customer pickup
    Then Order completes without rider assignment

  @BM-ORDER-010 @P0
  Scenario: Cancellation retry
    Given A cancellation was already handled
    When Retry cancellation
    Then Stock and financial effects occur once

  @BM-ORDER-011 @P0
  Scenario: Reorder sold-out item
    Given A past order contains a now unavailable item
    When Choose reorder
    Then Availability is rechecked and unavailable lines are explained

  @BM-ORDER-012 @P0
  Scenario: Customer isolation
    Given Two customers with different orders
    When Customer B requests customer A order
    Then Access is denied without exposing order details
