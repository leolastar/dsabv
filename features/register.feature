Feature: Register for an event
	In order to sign up for an event
	As a user
	I need a way register for an event and to be check in

	Scenario: Find an event and register as a user
    Given an admin created an event
        And an admin creates a timeslot
        And I am login as an user
        And I am on the event page
    Then I should see "Register"
    When I follow "Register"
    Then I should be on my registrations page
        And I should see "Test event"
    When I follow "Test event"
    Then I should be on the event page
        And I should see "Registered"

    Scenario: Check users in as an admin
    Given an admin created an event
        And an admin creates a timeslot
        And an user registers the event
        And I am login as an admin
        And I am on the event page
    Then I should see "Roster"
    When I go to the events roster
    Then I should be on the events roster
        And I should see "Check in"
        And I should not see "Checked"
    When I follow "Check in"
    Then I should be on the events roster
        And I should not see "Check in"
        And I should see "Checked"

    Scenario: Users can't see event roster
    Given an admin created an event
        And I am login as an user   
        And I am on the events page
    When I click on an event
    Then I should not see "Roster"
    When I go to the events roster
    Then I should be on the home page