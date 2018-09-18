Feature: Deducting Expense
  In order to monitor my finances
  As a user
  I want to be able to deduct expense

  Background:
    Given I am a user
    And I own a ledger
    And I am logged in

  Scenario: I am able to deduct expense
    When I select the deduct expense section
    And I set the expense amount to 600
    And I set the expense type to 'Groceries'
    And I set the expense date to 15/07/2017
    And I add an expense note to say 'Toiletries'
    And I submit the expense
    Then I should see the expense added to my own ledger
    And the expense form should reset

  Scenario: I am able to see errors
    When I select the deduct expense section
    And I submit the expense
    Then I should see the expense amount error
    And I should see the expense type error
    And I should see the expense date error

