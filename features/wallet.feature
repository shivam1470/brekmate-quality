# Generated from catalogue/scenarios; do not edit.
Feature: BM-WALLET

  @BM-WALLET-001 @P0
  Scenario: No topup
    Given A customer reward wallet
    When Attempt customer topup
    Then Unsupported topup is rejected

  @BM-WALLET-002 @P0
  Scenario: No withdrawal
    Given A customer reward balance
    When Attempt cash withdrawal or transfer
    Then Unsupported withdrawal is rejected

  @BM-WALLET-003 @P0
  Scenario: Concurrent redemption
    Given Balance sufficient for only one of two redemptions
    When Submit two orders concurrently
    Then Committed redemption never exceeds balance

  @BM-WALLET-004 @P0
  Scenario: Ledger balance
    Given Multiple credits/debits and reversals
    When Fetch history and balance
    Then Balance reconciles to committed ledger entries

  @BM-WALLET-005 @P0
  Scenario: Client balance tampering
    Given Client changes claimed wallet balance
    When Checkout using fabricated balance
    Then Authoritative balance is used

  @BM-WALLET-006 @P0
  Scenario: Redemption retry
    Given An order debit was already committed
    When Retry the same operation
    Then No second debit occurs

  @BM-WALLET-007 @P0
  Scenario: Cancelled debit reversal
    Given A debited order is cancelled under approved policy
    When Process cancellation repeatedly
    Then Eligible reversal occurs at most once

  @BM-WALLET-008 @P0
  Scenario: Cross-account wallet
    Given Customer A has rewards
    When Customer B requests A ledger or spends A funds
    Then Read and write access are denied
