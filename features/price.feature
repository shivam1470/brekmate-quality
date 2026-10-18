# Generated from catalogue/scenarios; do not edit.
Feature: BM-PRICE

  @BM-PRICE-001 @P0
  Scenario: Threshold below
    Given Delivery subtotal is 9899 paise
    When Quote the order
    Then Delivery fee is 2000 paise

  @BM-PRICE-002 @P0
  Scenario: Threshold exact
    Given Delivery subtotal is 9900 paise
    When Quote the order
    Then Delivery fee is 2000 paise

  @BM-PRICE-003 @P0
  Scenario: Threshold above
    Given Delivery subtotal is 9901 paise
    When Quote the order
    Then Delivery fee is zero

  @BM-PRICE-004 @P0
  Scenario: Pickup fee
    Given Valid pickup order below threshold
    When Quote the order
    Then Delivery fee is zero

  @BM-PRICE-005 @P0
  Scenario: Wallet threshold independence
    Given Subtotal exceeds 9900 before reward redemption
    When Redeem rewards and quote
    Then Free delivery stays free even if cash payable is below 9900

  @BM-PRICE-006 @P0
  Scenario: Wallet 20 percent
    Given Eligible subtotal is 15000 and reward balance is sufficient
    When Apply reward credit
    Then Applied reward is at most 3000 paise

  @BM-PRICE-007 @P0
  Scenario: Wallet balance cap
    Given Reward balance is below the 20 percent allowance
    When Apply reward credit
    Then Applied reward does not exceed available balance

  @BM-PRICE-008 @P0
  Scenario: Wallet disabled
    Given A customer has reward balance
    When Turn reward use off
    Then Applied reward is zero and total is recomputed

  @BM-PRICE-009 @P0
  Scenario: Taxes excluded from cap
    Given Subtotal and tax are nonzero
    When Calculate reward allowance
    Then Only eligible item subtotal determines the cap

  @BM-PRICE-010 @P0
  Scenario: Delivery excluded from cap
    Given Paid delivery and nonzero subtotal
    When Calculate reward allowance
    Then Delivery fee does not increase the cap

  @BM-PRICE-011 @P0
  Scenario: Empty checkout
    Given Cart contains no items
    When Request quote and place order
    Then No empty order or charge is created

  @BM-PRICE-012 @P0
  Scenario: Invalid quantities
    Given Client sends zero, negative or fractional quantity
    When Request quote
    Then Input is rejected without mutating stock or balance

  @BM-PRICE-013 @P0
  Scenario: Money precision
    Given A supported non-round paise subtotal
    When Apply rewards
    Then Integer-paise rounding follows the explicitly approved rounding rule

  @BM-PRICE-014 @P0
  Scenario: Quote/payment consistency
    Given An accepted quote and unchanged cart
    When Proceed to payment
    Then Payment request, receipt and order use the same server total
