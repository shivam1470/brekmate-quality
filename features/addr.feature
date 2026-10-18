# Generated from catalogue/scenarios; do not edit.
Feature: BM-ADDR

  @BM-ADDR-001 @P1
  Scenario: In-zone address
    Given Valid coordinates within configured radius
    When Request delivery quote
    Then Address is serviceable

  @BM-ADDR-002 @P1
  Scenario: Outside zone
    Given Coordinates outside configured radius
    When Attempt delivery checkout
    Then Delivery is refused even when subtotal exceeds the free threshold

  @BM-ADDR-003 @P1
  Scenario: Boundary radius
    Given Address exactly at configured radius
    When Evaluate serviceability
    Then Result follows the approved inclusive/exclusive boundary policy

  @BM-ADDR-004 @P1
  Scenario: Missing coordinates
    Given An incomplete or ungeocoded address
    When Attempt delivery checkout
    Then User is asked for adequate location information; no assumed serviceability

  @BM-ADDR-005 @P1
  Scenario: Address ownership
    Given Customer A owns a saved address
    When Customer B requests or changes it
    Then Access is denied without leaking address data

  @BM-ADDR-006 @P1
  Scenario: Address persistence
    Given A customer saves an address
    When Restart and sign in again
    Then Saved address is available to its owner

  @BM-ADDR-007 @P1
  Scenario: Permission denied
    Given Device location permission denied
    When Choose a delivery address
    Then Manual address selection remains possible

  @BM-ADDR-008 @P1
  Scenario: Pickup without delivery address
    Given Valid pickup order
    When Checkout without a delivery address
    Then No delivery address or delivery fee is required
