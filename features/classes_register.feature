Feature: Register for a class
	In order to sign up for a class
	As a user
	I need a way register for a class and to be check in

	Scenario: Find an class and register as a user
    Given an admin created a class
        And an admin creates a class slot
        And I am login as an user
        And I am on the class page
    Then I should see "Register"
    When I follow "Register"
    Then I should be on my registrations page
        And I should see "Test class"
    When I follow "Test class"
    Then I should be on the class page
        And I should see "Registered"
        And I should see "Unregister"

    Scenario: Unregister for an class as a user
    Given an admin created a class
        And an admin creates a class slot
        And an user registers for this class
        And I am login as an user
    When I go to the class page
        And I should see "Registered"
        And I should see "Unregister"
    When I follow "Unregister"
    Then I should be on my registrations page
    Then I go to the class page
    Then I should see "Register"
        And I should not see "Unregister"
        And I should not see "Registered"


    Scenario: Check users in as an admin
    Given an admin created a class
        And an admin creates a class slot
        And an user registers for this class
        And I am login as an admin
        And I am on the class page
    Then I should see "Roster"
    When I follow "Roster"
    Then I should be on the class roster
        And I should see "Check in"
        And I should not see "Checked"
    When I follow "Check in"
    Then I should be on the class roster
        And I should not see "Check in"
        And I should see "Checked"

    Scenario: Users can't see class roster
    Given an admin created an class
        And I am login as an user   
        And I visit the classes page
    When I click on a class
    Then I should not see "Roster"
    When I go to the class roster
    Then I should be on the home page