Feature: Logging in
  In order to use with the app
  As a user
  I want to able to log in

  Background:
    Given I am not logged in

  Scenario: I am able to log in
    Given I have a google account
    And I visit the 'home' page
    When I log in
    Then I should see the 'welcome' page

  Scenario: I fail to log in
    Given I visit the 'home' page
    And I don't have a google account
    When I log in
    Then I should see the 'home' page

  Scenario: I access a page that needs authentication
    Given I have a google account
    When I visit the 'welcome' page
    Then I should see the 'home' page

  Scenario: I login and I already have a ledger
    Given I am a user
    And I own a ledger
    When I log in from home
    Then I should see my owned ledger page

