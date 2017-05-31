Feature: Adding Income
  In order to monitor my finances
  As a user
  I want to be able to add income

  Background:
    Given I am a user
    And I own a ledger
    And I am logged in

  Scenario: I am able to add income
    When I select the add income section
    Then I could set the income amount to 500
