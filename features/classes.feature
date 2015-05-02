Feature: Events Management
    In order to manage classes
    As an admin
    I need a way to create, view classes, and check users in

    Scenario: Create an class
    Given I am login as an admin                
        And I am on the ds classes page
    When I create a new class
    Then I should see this new class

    Scenario: Create an class as an user
    Given I am login as an user                
        And I am on the ds classes page
    Then I should not see "Add new class"

    Scenario: Add timeslots as an admin
    Given I am login as an admin                
        And I am on the ds classes page
        And an class is created
    When I click on an class
    Then I should not see an timeslot
    When I create a timeslot
    Then I should be on the ds classes page
        And I should see this new timeslot

    Scenario: Add timeslots doesn't work for a user
    Given an admin created an event
        And I am login as an user
        And I am on the events page
    When I click on an event
    Then I should not see "Add time slot"
    When I go to the add time slot page
    Then I should be on the home page

    Scenario: Add day to a timeslot as an admin
    Given an admin created an event
        And an admin creates a timeslot
        And I am login as an admin
    Then I am on the class page
    When I follow "Add day of the week"
    Then I should be on the add day page
    # fill out the form

    Scenario: Date format on Classes page
    Given I am login as an admin
        And I am on the classes page
        And an class is created
    Then I should see the class
        And the correct date is shown