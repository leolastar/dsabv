Feature: Redirect after login
	In to register
	As a visitor to the site
	I need a way to redirect back to the event once I login

	Scenario: Redirect back after login in
    Given an admin created an event
        And an admin creates a timeslot
        And an user registers the event
        And I am on the event page
    When I follow "Register"
    Then I should be on the login page
        And I fill in "Email" with "test@test.com"
        And I fill in "Password" with "password"
    When I press "Login"
    Then I should be on the event page


