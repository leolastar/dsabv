Feature: Login and Signup
	In to manage the site and volunteer
	As a user
	I need a way to sign up and login

	Scenario: Login to site as a user
    Given I visit the home page
    When I am a user
        And I follow "Log in"
    Then I should be on the login page
        And I fill in "Email" with "test@test.com"
        And I fill in "Password" with "password"
    When I press "Login"
    Then I should be on my user page


    Scenario: Login to site as an admin
    Given I visit the home page
    When I am an admin
        And I follow "Log in"
    Then I should be on the login page
        And I fill in "Email" with "admin@admin.com"
        And I fill in "Password" with "password"
    When I press "Login"
    Then I should be on my admin page

    Scenario: Signup as a volunteer site
    Given I visit the home page
    When I follow "Sign up"
    Then I should be on the sign up page
        And I fill in "Name" with "test"
        And I fill in "Email" with "testing@testing.com"
        And I fill in "Password" with "password"
        And I fill in "Password Confirmation" with "password"
        And I fill in "Phone Number" with "(999) 000-0000"
        And I fill in "Address" with "123 Main St"
        And I fill in "Emergency contact name" with "My friend"
        And I fill in "Emergency contact phone" with "(999) 000-0000"
    When I create my account
    Then I should be on the home page