Feature: Buddy walks Management
    In order to manage the buddy walk
    As an admin
    I need a way to create, view buddy walks, and check users in

    Scenario: Create the first buddy walk
    Given I am login as an admin                
        And I visit the buddy walks page
    When I create a new buddy walk
    Then I should see this new buddy walk

    Scenario: Create the first buddy walk as an user
    Given I am login as an user                
        And I visit the classes page
    Then I should not see "Schedule Buddy Walk Event"
        And I should not see "Add new Registration Deal "
        And I should not see "Change Buddy Walk Schedule "
        And I should not see "Change time slot of buddy walk"
        And I should not see "Add time slot to buddy walk"
    When I go to the new buddy walk page
    Then I should be on the home page

    Scenario: Create the second buddy walk
    Given I am login as an admin                
        And I visit the buddy walks page
    When I create a new buddy walk
    Then I should see this new buddy walk
    When I create another buddy walk
    Then I should see both buddy walks with the same date

    Scenario: Create the second buddy walk as an user
    Given an admin creates a buddy walk
        And I am login as an user                
        And I visit the buddy walks page
    Then I should see "Test buddy walk"
        And I should not see "Schedule Buddy Walk Event"
        And I should not see "Add new Registration Deal "
        And I should not see "Change Buddy Walk Schedule "
        And I should not see "Change time slot of buddy walk"
        And I should not see "Add time slot to buddy walk"
    When I go to the schedule buddy walk page
    Then I should be on the home page

    Scenario: Add buddy slots doesn't work for a user
    Given an admin creates a buddy walk
        And I am login as an user
        And I visit the buddy walks page
    Then I should not see "Schedule Buddy Walk Event"
        And I should not see "Add new Registration Deal"
        And I should not see "Change Buddy Walk Schedule"
        And I should not see "Change time slot of buddy walk"
        And I should not see "Add time slot to buddy walk"
    When I follow "Test buddy walk"
    Then I should not see a buddy slot
    When I go to the add buddy slot to buddy walks page
    Then I should be on the home page

    Scenario: Add buddy slot as an admin
    Given an admin creates a buddy walk
        And I am login as an admin           
        And I visit the buddy walks page
    When I follow "Test buddy walk"
    Then I should not see a buddy slot
    When I create a buddy slot
    Then I should be on the buddy walks page
    When I follow "Test buddy walk"
    Then I should see this new buddy slot

    Scenario: Add buddy slot as an admin with two buddy walks
    Given an admin creates a buddy walk
        And an admin creates another buddy walk
        And I am login as an admin           
        And I visit the buddy walks page
    When I follow "Test buddy walk"
    Then I should not see a buddy slot
    When I follow "Back"
    Then I should be on the buddy walks page
    When I follow "Another Deal"
    Then I should not see a buddy slot
    When I create a buddy slot
    Then I should be on the buddy walks page
    When I follow "Test buddy walk"
    Then I should see this new buddy slot
    When I follow "Back"
    Then I should be on the buddy walks page
    When I follow "Another Deal"
    Then I should see this new buddy slot

    Scenario: Add buddy walk as an admin after buddy slot was added
    Given an admin creates a buddy walk
        And I am login as an admin           
        And I visit the buddy walks page
    Then I create a buddy slot
    When I create another buddy walk
    Then I should see both buddy walks with the same date
    Then I should be on the buddy walks page
    When I follow "Test buddy walk"
    Then I should see this new buddy slot
    When I follow "Back"
    Then I should be on the buddy walks page
    When I follow "Another Deal"
    Then I should see this new buddy slot

    Scenario: Change buddy walk location and time
    Given an admin creates a buddy walk
        And I am login as an admin           
        And I visit the buddy walks page
    When I change the buddy walk schedule
    Then I should see that the schedule changed

    Scenario: Change buddy walk location and time as an user
    Given an admin creates a buddy walk
        And I am login as an user           
        And I visit the buddy walks page
    Then I should not see "Schedule Buddy Walk Event"
        And I should not see "Add new Registration Deal"
        And I should not see "Change Buddy Walk Schedule"
        And I should not see "Change time slot of buddy walk"
        And I should not see "Add time slot to buddy walk"
    When I go to the edit buddy slot of buddy walks page
    Then I should be on the home page

    Scenario: Add a buddy walk after a change in buddy walk schedule and buddy slot times
    Given an admin creates a buddy walk
        And I am login as an admin           
        And I visit the buddy walks page
    Then I create a buddy slot
    When I change the buddy walk schedule
        And I change the buddy slot
    Then I should see that the schedule changed
        And I should see that the time change

    Scenario: Date format on Buddy walks page
    Given an admin creates a buddy walk
        And I am login as an admin
        And I visit the buddy walks page
    Then I should see this new buddy walk
        And the correct date is shown on buddy walks