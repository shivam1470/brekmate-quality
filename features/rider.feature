# Generated from catalogue/scenarios; do not edit.
Feature: BM-RIDER

  @BM-RIDER-001 @P1
  Scenario: Manual assignment
    Given An available rider and ready order
    When Staff assigns rider
    Then Assigned rider sees the correct order

  @BM-RIDER-002 @P1
  Scenario: Unauthorised assignment
    Given Customer or unprivileged staff
    When Assign rider
    Then Mutation is denied

  @BM-RIDER-003 @P1
  Scenario: Rider isolation
    Given Rider A and rider B assignments
    When Rider B opens rider A order
    Then Unassigned customer details/actions are unavailable

  @BM-RIDER-004 @P1
  Scenario: Navigation
    Given Assigned order has a destination
    When Open maps navigation
    Then Correct destination is passed to an installed maps handler

  @BM-RIDER-005 @P1
  Scenario: Valid delivery OTP
    Given Assigned in-transit order with current OTP
    When Submit correct code
    Then Delivery completes once

  @BM-RIDER-006 @P1
  Scenario: Wrong delivery OTP
    Given Assigned in-transit order
    When Submit incorrect code
    Then Delivery does not complete; attempts are limited

  @BM-RIDER-007 @P1
  Scenario: Cross-order OTP
    Given Two orders with distinct codes
    When Use order A code on order B
    Then Confirmation is rejected

  @BM-RIDER-008 @P1
  Scenario: Failed delivery
    Given Delivery cannot be completed
    When Record failed attempt and reason
    Then Order is not falsely marked delivered or COD collected

  @BM-RIDER-009 @P1
  Scenario: Rider reassignment
    Given Order assigned to rider A
    When Authorised staff reassigns to B
    Then A loses mutation rights and B receives assignment

  @BM-RIDER-010 @P1
  Scenario: OTP replay
    Given An order was delivered
    When Reuse its code
    Then No duplicate completion, collection or referral effect
