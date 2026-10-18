# Generated from catalogue/scenarios; do not edit.
Feature: BM-CAT

  @BM-CAT-001 @P1
  Scenario: Available catalogue
    Given Available and unavailable menu items
    When Browse and search customer catalogue
    Then Only orderable items are offered for addition

  @BM-CAT-002 @P1
  Scenario: Availability propagation
    Given Staff disables an item
    When Refresh catalogue on a second customer device
    Then The disabled item is no longer orderable

  @BM-CAT-003 @P1
  Scenario: Stale cart
    Given An item is disabled after being added
    When Attempt checkout
    Then Order is blocked with an actionable item-unavailable message

  @BM-CAT-004 @P1
  Scenario: Price change
    Given Price changes after cart creation
    When Request checkout quote
    Then Current server price is shown and consent required before charging a changed total

  @BM-CAT-005 @P1
  Scenario: Category disable
    Given Staff disables a category
    When Browse its products and attempt direct ordering
    Then Products in that category cannot be ordered

  @BM-CAT-006 @P1
  Scenario: Store closed
    Given Store is offline
    When Browse and submit an order
    Then Closed state is shown and new immediate orders are rejected

  @BM-CAT-007 @P1
  Scenario: Customisation retention
    Given An item has paid add-ons and instructions
    When Add quantity two and reopen cart
    Then Add-ons, quantity and instructions persist with correct line total

  @BM-CAT-008 @P1
  Scenario: Distinct cart lines
    Given Same item with different customisations
    When Add both configurations
    Then The configurations remain distinguishable and independently editable

  @BM-CAT-009 @P1
  Scenario: Tampered item price
    Given A client sends a changed item price
    When Request a quote
    Then Server uses the authoritative catalogue price

  @BM-CAT-010 @P1
  Scenario: Pure vegetarian menu
    Given Admin creates a product
    When Attempt to publish a nonvegetarian item
    Then Publishing follows the pure-vegetarian catalogue constraint
