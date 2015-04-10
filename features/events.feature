Feature: Events Management
	In order to manage events
	As an admin
	I need a way to create, view events, and check users in

	Scenario: Create an event
    Given I am login in as an admin                
        And I am on the events page
    When I create a new event
    Then I should see this new event

    Scenario: Create an event as an user
    Given I am login in as an user                
        And I am on the events page
    Then I should not see "Add new event"

    Scenario: Add timeslots


    Scenario: Check users in