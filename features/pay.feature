# Generated from catalogue/scenarios; do not edit.
Feature: BM-PAY

  @BM-PAY-001 @P0
  Scenario: UPI success
    Given A valid order and sandbox UPI payment
    When Receive verified success
    Then Order becomes paid once for the verified amount

  @BM-PAY-002 @P0
  Scenario: Card success
    Given A valid order and sandbox card payment
    When Complete successful card checkout
    Then Only gateway references are stored; sensitive card data is not retained

  @BM-PAY-003 @P0
  Scenario: Payment decline
    Given Gateway declines payment
    When Return to checkout
    Then No paid status or reward is issued; recovery is available

  @BM-PAY-004 @P0
  Scenario: User cancellation
    Given Gateway checkout is open
    When Cancel and return to app
    Then Order is not falsely marked paid

  @BM-PAY-005 @P0
  Scenario: Forged client success
    Given No successful gateway payment exists
    When Client claims payment success
    Then Backend refuses to trust the client claim

  @BM-PAY-006 @P0
  Scenario: Invalid webhook signature
    Given An unsigned or incorrectly signed payment event
    When Deliver webhook
    Then Event is rejected without state mutation

  @BM-PAY-007 @P0
  Scenario: Amount mismatch
    Given Signed webhook has an unexpected amount or currency
    When Process event
    Then Order is not incorrectly settled; discrepancy is surfaced

  @BM-PAY-008 @P0
  Scenario: Duplicate webhook
    Given A successful event already processed
    When Replay the same event concurrently
    Then Exactly one payment ledger effect occurs

  @BM-PAY-009 @P0
  Scenario: Delayed success
    Given App has timed out before provider success
    When Reconcile a later verified event
    Then Payment is resolved consistently without duplicate charge/order

  @BM-PAY-010 @P0
  Scenario: Out-of-order events
    Given Success has already been verified
    When Receive an older pending event
    Then Paid state does not regress

  @BM-PAY-011 @P0
  Scenario: App killed during payment
    Given Gateway operation is in progress
    When Terminate and reopen app
    Then Backend payment state is recovered; no assumed success

  @BM-PAY-012 @P0
  Scenario: COD checkout
    Given A valid COD order
    When Place order
    Then Order is unpaid/COD-due rather than prepaid

  @BM-PAY-013 @P0
  Scenario: COD collection
    Given Assigned rider delivers a COD order
    When Record confirmed collection once
    Then Collected amount is recorded exactly once and becomes auditable

  @BM-PAY-014 @P0
  Scenario: Provider unavailable
    Given Payment gateway is unreachable
    When Attempt prepaid checkout
    Then Failure is recoverable without duplicate inventory or wallet deductions
