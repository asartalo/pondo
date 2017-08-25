Feature: Subscribing
  In order to contribute to a ledger
  As a prospecting subscriber
  I want to be able to subscribe to a ledger

  Background:
    Given A user invited me to a ledger

  Scenario: I am able to subscribe as a new user
    Given I have a google account
    When I log in for the first time
    Then I should see a link to subscribe to the ledger
    And I should be able to subscribe to the ledger

  Scenario: I am able to subscribe as a non-user
    Given I have a google account
    When I follow the ledger subscription link
    Then I should see a link to sign up
    And I should see the ledger

  Scenario: I am able to subscribe as a non-user even with a different email
    Given I have a different google account
    When I follow the ledger subscription link
    Then I should see a link to sign up
    And I should see the ledger

  Scenario: I am unable to subscribe with a used subscription
    Given the invite is used
    And I have a google account
    When I follow the ledger subscription link
    Then I should see the 'home' page

