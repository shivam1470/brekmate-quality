# Generated from catalogue/scenarios; do not edit.
Feature: BM-OPS

  @BM-OPS-001 @P1
  Scenario: Database failure
    Given Database becomes unavailable during checkout
    When Submit order
    Then No false confirmation or partial untracked financial mutation

  @BM-OPS-002 @P1
  Scenario: Transaction rollback
    Given Failure between wallet debit and order commit
    When Retry after recovery
    Then Atomic outcome or documented compensation preserves ledger consistency

  @BM-OPS-003 @P1
  Scenario: Worker retry
    Given An async event handler fails after partial work
    When Redeliver event
    Then Idempotent processing prevents repeated side effects

  @BM-OPS-004 @P1
  Scenario: Restore rehearsal
    Given Known fixture database backup
    When Restore into isolated environment
    Then Orders, ledger and constraints reconcile

  @BM-OPS-005 @P1
  Scenario: Real IAM
    Given Deployed staging with least-privilege roles
    When Run allowed and prohibited AWS operations
    Then Required access works and forbidden access is denied

  @BM-OPS-006 @P1
  Scenario: Actual event wiring
    Given Real staging event source and handler
    When Publish integration event
    Then Correct deployed handler processes event; emulator success alone is insufficient

  @BM-OPS-007 @P1
  Scenario: Load target
    Given Approved peak load and latency/error budgets
    When Run isolated load test
    Then Measured results satisfy approved budgets; no invented numeric SLO

  @BM-OPS-008 @P1
  Scenario: Production build
    Given Signed release candidates on Android and iPhone
    When Run full critical customer/staff/rider journeys
    Then Native release builds pass required device checks

  @BM-OPS-009 @P1
  Scenario: Account deletion release
    Given Published deletion/help/privacy links
    When Exercise deletion and review disclosures
    Then App behaviour and store disclosures agree

  @BM-OPS-010 @P1
  Scenario: Cost isolation
    Given Local test run and temporary staging stack
    When Execute and clean up tests
    Then Local suite needs no AWS credentials; cleanup protects production and persistent state
