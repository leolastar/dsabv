Feature: Staff can check people in for buddy walk
	In order for a staff memeber to check user in to buddy walk
	As an admin
	I need a way to give users the staff role

    Scenario: Staff members can check people in to buddy walk
    Given an admin creates a buddy walk
        And an admin created a buddy slot
        And an user registers for this buddy walk
        And an admin has a staff memember
    Then I am login as an user
    When I go to the buddy walk page
        And I should see "Roster"
    When I follow "Roster"
    Then I should be on the buddy walk roster
        And I should see "Check in"
        And I should not see "Checked"
    When I follow "Check in"
    Then I should be on the buddy walk roster
        And I should not see "Check in"
        And I should see "Checked"

    Scenario: Staff members who lose the staff role can't view an buddy walk roster
    Given an admin creates a buddy walk
        And an admin created a buddy slot
        And an user registers for this buddy walk
        And an admin has a staff memember
    Then an admin removes staff role
    Then I am login as an user
    When I go to the buddy walk page
        And I should not see "Roster"
    When I go to the buddy walk roster
    Then I should be on the home page
