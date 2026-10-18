# Generated from catalogue/scenarios; do not edit.
Feature: BM-STAFF

  @BM-STAFF-001 @P1
  Scenario: Unauthenticated staff
    Given No staff session
    When Open staff APIs
    Then No operational data or mutation access

  @BM-STAFF-002 @P1
  Scenario: Kitchen price restriction
    Given Kitchen-only role
    When Change product price
    Then Operation is denied

  @BM-STAFF-003 @P1
  Scenario: Authorised price change
    Given Owner/manager with granted permission
    When Change price
    Then Change is applied and audited

  @BM-STAFF-004 @P1
  Scenario: Role escalation
    Given Low-privilege staff user
    When Modify own role or forged token claims
    Then Privilege escalation is denied

  @BM-STAFF-005 @P1
  Scenario: New-order alert
    Given A customer places an order
    When Observe cafe order board
    Then New order appears with persistent visual indication

  @BM-STAFF-006 @P1
  Scenario: Disconnected operator
    Given Staff interface loses connection
    When Attempt an order transition
    Then UI does not falsely claim a server-confirmed update

  @BM-STAFF-007 @P1
  Scenario: Two operator race
    Given Two staff members handle one new order
    When Accept and reject concurrently
    Then One consistent outcome with conflict handling

  @BM-STAFF-008 @P1
  Scenario: Config audit
    Given Authorised admin changes fees or capacity
    When Save configuration
    Then Actor, old/new values and timestamp are auditable
