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
    And I set the income amount to 500
    And I set the income source to 'Salary'
    And I set the income date to 15/07/2017
    And I add an income note to say 'Work'
    And I submit the income
    Then I should see the income added to my own ledger
    And the income form should reset

  Scenario: I am able to see errors
    When I select the add income section
    And I submit the income
    Then I should see the income amount error
    And I should see the income source error
    And I should see the income date error


