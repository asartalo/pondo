Feature: Errors
  In order to confidently use nitrolinks
  As a developer
  I want nitrolinks to just load error pages

  @nitrolinks @allow-rescue
  Scenario: Nitro 404
    When I click on the '404' hyperlink
    Then I should see the 404 error page

  @nitrolinks @allow-rescue
  Scenario: Nitro 500
    When I click on the '500' hyperlink
    Then I should see the 500 error page
