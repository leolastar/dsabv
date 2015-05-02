Feature: Login and Signup
	In to manage the site and volunteer
	As a user
	I need a way to sign up and login

	Scenario: Login to site as a user
    Given I visit the home page
    When I am an user
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

    Scenario: Logout as an admin
    Given I am login as an admin
        And I visit the home page
    Then I should be on the home page
    When I follow "Log out"
    Then I should see "Log in"

    Scenario: Logout as an user
    Given I am login as an user
        And I visit the home page
    Then I should be on the home page
    When I follow "Log out"
    Then I should see "Log in"