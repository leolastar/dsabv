Feature: Staff can check people in
	In order for a staff memeber to check user in
	As an admin
	I need a way to give users the staff role

	Scenario: Give an user a staff role
    Given I am login as an admin
        And an user is signed up
        And I visit the home page
    Then I should see "Users"
    When I follow "Users"
    Then I should see "admin@admin.com"
        And I should see "test@test.com"
        And I should not see "remove staff role"
        And I should see "add staff role"
    When I follow "add staff role"
    Then I should be on the users page
        And I should see "remove staff role"
        And I should not see "add staff role"

    Scenario: Remove the staff role from a user
    Given I am login as an admin
        And an user is signed up
        And I am on the users page
        And I made him a staff member
    Then I should see "admin@admin.com"
        And I should see "test@test.com"
        And I should see "remove staff role"
        And I should not see "add staff role"
    When I follow "remove staff role"
    Then I should be on the users page
        And I should see "add staff role"
        And I should not see "remove staff role"

    Scenario: Users can't view all the users
    Given I am login as an user
        And I visit the home page
    When I go to the users page
    Then I should be on the home page
        And I should not see "Users"

    Scenario: Staff members can't view all the users
    Given I am login as an admin
        And an user is signed up
        And I am on the users page
        And I made him a staff member
    Then I logout as an admin
        And I am login as an user
        And I visit the home page
    When I go to the users page
    Then I should be on the home page
        And I should not see "Users"

    Scenario: Staff members can check people in
    Given an admin created an event
        And an admin creates a timeslot
        And an user registers the event
        And an admin has a staff memember
    Then I am login as an user
    When I go to the event page
        And I should see "Roster"
    When I go to the events roster
    Then I should be on the events roster
        And I should see "Check in"
        And I should not see "Checked"
    When I follow "Check in"
    Then I should be on the events roster
        And I should not see "Check in"
        And I should see "Checked"

    Scenario: Staff members who lose the staff role can't view an event roster
    Given an admin created an event
        And an admin creates a timeslot
        And an user registers the event
        And an admin has a staff memember
    Then an admin removes staff role
    Then I am login as an user
    When I go to the event page
        And I should not see "Roster"
    When I go to the events roster
    Then I should be on the home page
