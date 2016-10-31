Feature: Logging in
  In order to use with the app
  As a user
  I want to able to log in

  Background:
    Given I am not logged in

  Scenario: I need to log in
    Given I visit the 'home' page
    When I log in
    Then I should see the 'dashboard' page
