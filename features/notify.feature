# Generated from catalogue/scenarios; do not edit.
Feature: BM-NOTIFY

  @BM-NOTIFY-001 @P1
  Scenario: Status update
    Given Authorised staff changes order state
    When Customer refreshes or receives event
    Then Timeline reflects authoritative order state

  @BM-NOTIFY-002 @P1
  Scenario: No fake progress
    Given Order remains preparing for a long time
    When Wait beyond prototype timers
    Then App does not invent ready/delivered status

  @BM-NOTIFY-003 @P1
  Scenario: Push denied
    Given Customer denies push permissions
    When Place and track order
    Then In-app status remains accessible

  @BM-NOTIFY-004 @P1
  Scenario: Duplicate notification
    Given Event delivered more than once
    When Process update
    Then Order history and notification effects are deduplicated

  @BM-NOTIFY-005 @P1
  Scenario: Foreground recovery
    Given Order changes while app backgrounded
    When Resume app
    Then Latest authoritative state is fetched

  @BM-NOTIFY-006 @P1
  Scenario: Notification isolation
    Given A notification targets customer A
    When Customer B requests notification details
    Then Private order details are not disclosed
