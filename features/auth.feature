# Generated from catalogue/scenarios; do not edit.
Feature: BM-AUTH

  @BM-AUTH-001 @P1
  Scenario: Phone sign-in
    Given A registered customer and controlled OTP provider
    When Submit correct unexpired OTP once
    Then One authenticated session is issued

  @BM-AUTH-002 @P1
  Scenario: Wrong OTP
    Given A pending sign-in challenge
    When Submit an incorrect OTP
    Then No session is issued and attempts are tracked

  @BM-AUTH-003 @P1
  Scenario: Expired OTP
    Given A challenge past its configured expiry
    When Submit its previously correct OTP
    Then Challenge is rejected without a session

  @BM-AUTH-004 @P1
  Scenario: OTP replay
    Given An OTP already used successfully
    When Submit it again
    Then No second session can be created using the consumed challenge

  @BM-AUTH-005 @P1
  Scenario: Challenge binding
    Given Two different phone challenges
    When Use phone A code for phone B challenge
    Then Verification is rejected

  @BM-AUTH-006 @P1
  Scenario: Rate limits
    Given Configured attempt and resend limits
    When Exceed the configured limit
    Then Requests are throttled without sending unlimited messages

  @BM-AUTH-007 @P1
  Scenario: Logout
    Given An authenticated customer
    When Logout and attempt a protected action
    Then The logged-out client cannot perform the action

  @BM-AUTH-008 @P1
  Scenario: Session refresh
    Given A valid refresh session
    When Refresh credentials
    Then A valid session is returned without exposing credentials in logs

  @BM-AUTH-009 @P1
  Scenario: Expired session
    Given An expired access credential
    When Request a protected resource
    Then Access is rejected or securely refreshed; no guest privilege escalation

  @BM-AUTH-010 @P1
  Scenario: Account deletion
    Given A signed-in customer with prior orders
    When Request deletion and complete required confirmation
    Then Access is revoked; data handling follows the documented retention policy
