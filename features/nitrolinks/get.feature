Feature: GET navigation
  In order to do things quickly
  As a user
  I want the page to be responsive

  @nitrolinks
  Scenario: Clicking
    When I click on the 'Link #1 - GET' hyperlink
    And I check the page loads
    Then I should see the 'nitrolinks_1' page
    And the 'nitrolinks_1' page should be loaded through ajax

  @nitrolinks
  Scenario: Clicking a link that redirects to a page within app
    When I click on the 'Redirecting Internal' hyperlink
    And I check the page loads
    Then I should see the 'redirected' page
    And the 'redirected' page should be loaded through ajax
