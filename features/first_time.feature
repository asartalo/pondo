Feature: First time account setup
  In order to get started quickly
  As a user
  I want to able to setup my account

  Background:
    Given I have a google account

  Scenario: I am able to setup my ledger after logging in
    When I log in for the first time
    Then I should see the UI to create my first ledger
    And I can set my first ledger's name to 'Family'
    And I can set the currency to 'PHP'
    And I can save the ledger
