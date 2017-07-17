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

  @nitrolinks
  Scenario: Going back and forward
    When I click on the 'Link #1 - GET' hyperlink
    Then I should see the 'nitrolinks_1' page
    And I go back
    And I go forward
    Then I should see the 'nitrolinks_1' page
    And the 'nitrolinks_1' page should be loaded from cache

  @nitrolinks
  Scenario: Going back before first load and forward
    When I should see the 'nitrolinks' page
    And I go back
    And I go forward
    Then I should see the 'nitrolinks' page
    And the 'nitrolinks' page should be loaded from cache

  @nitrolinks
  Scenario: Managing change in content
    When I enter 'Foo' on the 'Track GET' text field
    And I hit the 'Changing GET Form' button
    Then I should see the 'nitrolinks' page
    And I should see 'Foo'

  @nitrolinks
  Scenario: POST with redirects
    When I enter 'FooPOST' on the 'Track POST' text field
    And I hit the 'Changing POST Form' button
    Then I should see the 'nitrolinks' page
    And I should see 'FooPOST'

  @nitrolinks
  Scenario: Reloading
    When I check the random uuid value on page
    And I reload the page
    Then I should see the 'nitrolinks' page
    And I should see a new uuid value on page

