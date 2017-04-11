Feature: Logging in
  In order to use with the app
  As a user
  I want to able to log in

  Background:
    Given I am not logged in

  Scenario: I am able to log in
    Given I have a google account
    Given I visit the 'home' page
    When I log in
    Then I should see the 'dashboard' page

  # Scenario: I fail to log in
    # ScGiven I visit the 'home' page
    # ScGiven I don't have a google account
    # ScWhen I log in
    # ScThen I should see the 'home' page

