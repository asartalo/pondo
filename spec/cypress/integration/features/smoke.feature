Feature: Homepage is accessible
	In order to use the app
	As a user
	I need to access the website

	Scenario: I can visit the homepage
		Given I'm a regular visitor
		When I visit the 'home' page
		Then I should see 'home' page
