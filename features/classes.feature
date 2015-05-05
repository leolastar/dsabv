Feature: Classes Management
    In order to manage classes
    As an admin
    I need a way to create, view classes, and check users in

    Scenario: Create an class
    Given I am login as an admin                
        And I visit the classes page
    When I create a new class
    Then I should see this new class

    Scenario: Create an class as an user
    Given I am login as an user                
        And I visit the classes page
    Then I should not see "Add new class"

    Scenario: Add class slots as an admin
    Given I am login as an admin                
        And I visit the classes page
        And an class is created
    When I click on an class
    Then I should not see an class slot
    When I create a class slot
    Then I should be on the class page
        And I should see this new class slot

    Scenario: Add class slots doesn't work for a user
    Given an admin created an class
        And I am login as an user
        And I visit the classes page
    When I click on an class
    Then I should not see "Add time slot"
    When I go to the add class slot page
    Then I should be on the home page

    Scenario: Add day to a class slot as an admin
    Given an admin created an class
        And an admin creates a class slot
        And I am login as an admin
    Then I am on the class page
    When I follow "Add day of the week"
    Then I should be on the add day page
        And I should see "Day of the week"
        And I select "Monday" from "Day of the week"
    When I press "Submit"
    Then I should be on the class page
        And I should see "Monday"
        And I should not see "Tuesday"
    When I follow "Add day of the week"
     Then I should be on the add day page
        And I should see "Day of the week"
        And I select "Tuesday" from "Day of the week"
    When I press "Submit"
    Then I should be on the class page
        And I should see "Monday"
        And I should see "Tuesday"


    Scenario: Date format on Classes page
    Given I am login as an admin
        And I visit the classes page
        And an class is created
    Then I should see the class
        And the correct date is shown on classes