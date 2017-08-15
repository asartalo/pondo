Feature: Subscription
  In order to use with the app
  As a user
  I want to able to invite new subscribers

  Background:
    Given I am a user
    And I own a ledger
    And I am logged in

  @focus @email
  Scenario: I am able to invite a user as subscriber
    When I invite "foo@foobar.com"
    Then the system should send an invite to "foo@foobar.com"


