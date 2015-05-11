Feature: Register for a buddy walk
	In order to sign up for a buddy walk
	As a user
	I need a way register for a buddy walk and to be check in

    Scenario: Users can't register before admin adds buddy slot
     Given an admin creates a buddy walk
        And I am login as an user           
        And I am on the buddy walk page
    Then I should not see "Register"
        And I should not see "Registered Users"

	Scenario: Find an buddy walk and register as a user
    Given an admin creates a buddy walk
        And an admin created a buddy slot
        And I am login as an user           
        And I am on the buddy walk page
    Then I should see "Register"
    When I follow "Register"
    Then I should be on my registrations page
        And I should see "Test buddy walk"
    When I follow "Test buddy walk"
    Then I should be on the buddy walk page
        And I should see "Registered Users: 1"
        And I should see "Registered"
        And I should see "Unregister"

    Scenario: Unregister for an buddy walk as a user
    Given an admin creates a buddy walk
        And an admin created a buddy slot
        And an user registers for this buddy walk
        And I am login as an user
    When I go to the buddy walk page
        And I should see "Registered"
        And I should see "Unregister"
    When I follow "Unregister"
    Then I should be on my registrations page
        And I should not see "Test buddy walk"
    Then I go to the buddy walk page
    Then I should see "Register"
        And I should see "Registered Users: 0"
        And I should not see "Unregister"

    Scenario: Check users in as an admin
     Given an admin creates a buddy walk
        And an admin created a buddy slot
        And an user registers for this buddy walk
        And I am login as an admin
        And I am on the buddy walk page
    Then I should see "Roster"
    When I follow "Roster"
    Then I should be on the buddy walk roster
        And I should see "Check in"
        And I should not see "Checked"
    When I follow "Check in"
    Then I should be on the buddy walk roster
        And I should not see "Check in"
        And I should see "Checked"

    Scenario: Users can't see buddy walk roster
    Given an admin creates a buddy walk
        And an admin created a buddy slot
        And I am login as an user   
        And I am on the buddy walk page
    Then I should not see "Roster"
    When I go to the buddy walk roster
    Then I should be on the home page