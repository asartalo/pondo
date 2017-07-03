Feature: GET navigation
  In order to do things quickly
  As a user
  I want the page to be responsive

  @nitrolinks
  Scenario: Clicking
    When I click on the 'Link #1 - GET' hyperlink
    Then I should see the 'nitrolinks_1' page
    And the 'nitrolinks_1' page should be loaded through ajax

  @nitrolinks
  Scenario: Clicking a link that redirects to a page within app
    When I click on the 'Redirecting Internal' hyperlink
    Then I should see the 'redirected' page
    And the 'redirected' page should be loaded through ajax

  @nitrolinks
  Scenario: Going back
    When I click on the 'Link #1 - GET' hyperlink
    Then I should see the 'nitrolinks_1' page
    And I go back
    Then I should see the 'nitrolinks' page
    And the 'nitrolinks' page should be loaded from cache
