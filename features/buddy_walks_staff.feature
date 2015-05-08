Feature: Staff can check people in
	In order for a staff memeber to check user in
	As an admin
	I need a way to give users the staff role

    Scenario: Staff members can check people in to classes
    Given an admin created a class
        And an admin creates a class slot
        And an user registers for this class
        And an admin has a staff memember
    Then I am login as an user
    When I go to the class page
        And I should see "Roster"
    When I follow "Roster"
    Then I should be on the class roster
        And I should see "Check in"
        And I should not see "Checked"
    When I follow "Check in"
    Then I should be on the class roster
        And I should not see "Check in"
        And I should see "Checked"

    Scenario: Staff members who lose the staff role can't view an class roster
    Given an admin created a class
        And an admin creates a class slot
        And an user registers for this class
        And an admin has a staff memember
    Then an admin removes staff role
    Then I am login as an user
    When I go to the class page
        And I should not see "Roster"
    When I go to the class roster
    Then I should be on the home page
