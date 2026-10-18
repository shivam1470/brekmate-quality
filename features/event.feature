# Generated from catalogue/scenarios; do not edit.
Feature: BM-EVENT

  @BM-EVENT-001 @P1
  Scenario: Venue information
    Given Published venue configuration
    When Open celebration section
    Then First-floor venue, approximate capacity, seating and lighting are accurately presented

  @BM-EVENT-002 @P1
  Scenario: Free venue
    Given Any valid party enquiry
    When Review terms
    Then Venue fee is zero and no minimum food order is imposed

  @BM-EVENT-003 @P1
  Scenario: Occasion theme
    Given Birthday, farewell and office gathering examples
    When Select an occasion
    Then Relevant theme information is shown without claiming unavailable decoration

  @BM-EVENT-004 @P1
  Scenario: Enquiry submission
    Given Valid contact, date/time, guest count and preferences
    When Submit enquiry
    Then One enquiry is recorded, explicitly not a confirmed reservation

  @BM-EVENT-005 @P1
  Scenario: Duplicate enquiry retry
    Given One successful enquiry with idempotency token
    When Retry after network timeout
    Then No accidental duplicate enquiry is created

  @BM-EVENT-006 @P1
  Scenario: Capacity limit
    Given Configured confirmed capacity N
    When Request N and N+1 guests
    Then Capacity policy is enforced and excess request is not silently confirmed

  @BM-EVENT-007 @P1
  Scenario: Overlapping confirmation
    Given Two enquiries for overlapping slots
    When Staff confirms concurrently
    Then At most one exclusive reservation is confirmed

  @BM-EVENT-008 @P1
  Scenario: Adjacent slots
    Given Two slots touching at a boundary
    When Confirm subject to configured buffer
    Then Result follows the approved duration/buffer rule

  @BM-EVENT-009 @P1
  Scenario: Past date
    Given Requested time is in the past in Asia/Kolkata
    When Submit enquiry
    Then Past-time booking request is rejected

  @BM-EVENT-010 @P1
  Scenario: Customer cancellation
    Given Customer owns an enquiry/reservation
    When Request cancellation
    Then Approved policy is followed and availability released appropriately

  @BM-EVENT-011 @P1
  Scenario: Decoration promotion active
    Given Current time within configured promotion
    When View enquiry inclusions
    Then Complimentary basic decoration and actual inclusions are displayed

  @BM-EVENT-012 @P1
  Scenario: Decoration promotion ended
    Given Promotion has expired
    When View celebration offer
    Then Expired complimentary offer is not promised

  @BM-EVENT-013 @P1
  Scenario: Free camera
    Given A customer selects camera use
    When Review enquiry summary
    Then Camera use is presented as free

  @BM-EVENT-014 @P1
  Scenario: Photo preferences
    Given Customer selects email or WhatsApp
    When Submit valid chosen-channel contact
    Then Chosen preference and contact are preserved

  @BM-EVENT-015 @P1
  Scenario: Contact validation
    Given Email or WhatsApp preference with invalid contact
    When Submit enquiry
    Then Selected-channel validation prevents invalid contact submission

  @BM-EVENT-016 @P1
  Scenario: Photography assistance
    Given Assistance availability/pricing unresolved
    When Request assistance
    Then Request is recorded without inventing confirmed availability or price

  @BM-EVENT-017 @P1
  Scenario: Photo consent
    Given Photo delivery consent given but marketing consent absent
    When Staff reviews permitted usage
    Then Delivery consent does not grant marketing rights

  @BM-EVENT-018 @P1
  Scenario: Event privacy
    Given Two customers have enquiries
    When Customer B reads or modifies A enquiry
    Then Access is denied
