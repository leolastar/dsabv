Feature: Events Management
	In order to manage events
	As an admin
	I need a way to create, view events, and check users in

	Scenario: Create an event
    Given I am login as an admin                
        And I am on the events page
    When I create a new event
    Then I should see this new event

    Scenario: Create an event as an user
    Given I am login as an user                
        And I am on the events page
    Then I should not see "Add new event"

    Scenario: Add timeslots as an admin
    Given I am login as an admin                
        And I am on the events page
        And an event is created
    When I click on an event
    Then I should not see an timeslot
    When I create a timeslot
    Then I should be on the event page
        And I should see this new timeslot

    Scenario: Add timeslots doesn't work for a user
    Given an admin created an event
        And I am login as an user
        And I am on the events page
    When I click on an event
    Then I should not see "Add time slot"
    When I go to the add time slot page
    Then I should be on the home page

    Scenario: Date format on Events page
    Given I am login as an admin
        And I am on the events page
        And an event is created
    Then I should see the event
        And the correct date is shown 
