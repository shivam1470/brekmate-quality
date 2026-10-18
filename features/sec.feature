# Generated from catalogue/scenarios; do not edit.
Feature: BM-SEC

  @BM-SEC-001 @P0
  Scenario: Injection
    Given SQL/metacharacters in user-controlled input
    When Submit search, instructions and event fields
    Then Inputs cannot execute database commands

  @BM-SEC-002 @P0
  Scenario: Stored script
    Given HTML/script text in instructions
    When Staff opens order
    Then User text is rendered safely without script execution

  @BM-SEC-003 @P0
  Scenario: Secret leakage
    Given App bundle, responses and logs
    When Inspect credentials and tokens
    Then No private gateway keys, cloud secrets or OTPs are exposed

  @BM-SEC-004 @P0
  Scenario: Staff CSRF
    Given Cookie-authenticated staff browser if used
    When Issue cross-origin forged mutation
    Then Chosen CSRF defence blocks the request

  @BM-SEC-005 @P0
  Scenario: Token validation
    Given Expired, wrong-audience or invalid-signature token
    When Call protected API
    Then All invalid tokens are rejected

  @BM-SEC-006 @P0
  Scenario: Resource limits
    Given Excessive body sizes and request rates
    When Send abusive requests
    Then Limits reject abuse without unbounded allocation

  @BM-SEC-007 @P0
  Scenario: Object authorisation
    Given Guessed order/address/enquiry IDs
    When Access as another customer
    Then Every object access enforces ownership/role

  @BM-SEC-008 @P0
  Scenario: Log privacy
    Given Customer contact and photo preferences
    When Trigger success and failure paths
    Then Logs follow redaction rules without secrets or unnecessary personal data
