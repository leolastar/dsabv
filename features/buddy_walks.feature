Feature: Buddy walks Management
    In order to manage the buddy walk
    As an admin
    I need a way to create, view buddy walks, and check users in

    Scenario: Create the first buddy walk
    Given I am login as an admin                
        And I visit the buddy page
    When I create a new class
    Then I should see this new class

    Scenario: Create the first buddy walk as an user
    Given I am login as an user                
        And I visit the classes page
    Then I should not see "Add new class"

    Scenario: Create the second buddy walk
    Given I am login as an admin                
        And I visit the classes page
    When I create a new class
    Then I should see this new class

    Scenario: Create the second buddy walk as an user
    Given I am login as an user                
        And I visit the classes page
    Then I should not see "Add new class"

    Scenario: Add buddy slots as an admin
    Given I am login as an admin                
        And I visit the classes page
        And an class is created
    When I click on an class
    Then I should not see an class slot
    When I create a class slot
    Then I should be on the class page
        And I should see this new class slot

    Scenario: Add buddy slots doesn't work for a user
    Given an admin created an class
        And I am login as an user
        And I visit the classes page
    When I click on an class
    Then I should not see "Add time slot"
    When I go to the add class slot page
    Then I should be on the home page

    Scenario: Add buddy slot as an admin with buddy walks already added

    Scenario: Add buddy walk as an admin after buddy slot was added

    Scenario: Change buddy walk location and time

    Scenario: Change buddy walk location and time as an user

    Scenario: Add a buddy walk after a change in buddy walk schedule and buddy slot times


    Scenario: Date format on Buddy walks page
    Given I am login as an admin
        And I visit the classes page
        And an class is created
    Then I should see the class
        And the correct date is shown on classes