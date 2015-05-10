require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

When(/^I create a new buddy walk$/) do
  steps %{
    Then I should be on the buddy walks page
      And I should see "Schedule Buddy Walk Event"
    When I follow "Schedule Buddy Walk Event"
    Then I should be on the new buddy walk page
      And I fill in "Title" with "Test buddy walk"
      And I fill in "Date" with "May 14, 2014"
      And I fill in "Location" with "A big park"
      And I fill in "Description" with "<h1>FUN FUN</h1>"
    When I press "Create new deal"
    Then I should be on the buddy walk page
      And I should see "Test buddy walk"
      And I should see "May 14, 2014"
      And I should see "Edit"
      And I should see "Delete"
    When I follow "Back"
    Then I should be on the buddy walks page
      And I should see "Test buddy walk"
      And I should see "May 14, 2014"
      And I should see "Edit"
      And I should see "Delete"
      And I should see "Add new Registration Deal"
      And I should see "Change Buddy Walk Schedule"
      And I should see "Add time slot to buddy walk"
      And I should not see "Schedule Buddy Walk Event"
      And I should not see "Change time slot of buddy walk"
  }
end

Given(/^a buddy walk for search is created$/) do
  steps %{
    Given I am on the buddy walks page
      And I should see "Schedule Buddy Walk Event"
    When I follow "Schedule Buddy Walk Event"
    Then I should be on the new buddy walk page
      And I fill in "Title" with "Family Registration"
      And I fill in "Date" with "June 12, 2014"
      And I fill in "Location" with "Anderson Park"
      And I fill in "Description" with "<h1>So much walking</h1>"
    When I press "Create new deal"
    Then I should be on the buddy walk page
      And I should see "Family Registration"
      And I should see "June 12, 2014"
      And I should see "Edit"
      And I should see "Delete"
    When I follow "Back"
    Then I should be on the buddy walks page
      And I should see "Family Registration"
      And I should see "June 12, 2014"
      And I should see "Edit"
      And I should see "Delete"
      And I should see "Add new Registration Deal"
      And I should see "Change Buddy Walk Schedule"
      And I should see "Add time slot to buddy walk"
      And I should not see "Schedule Buddy Walk Event"
      And I should not see "Change time slot of buddy walk"
  }
end

Then(/^I should see this new buddy walk$/) do
  steps %{
    Then I should be on the buddy walks page
      And I should see "Test buddy walk"
      And I should see "May 14, 2014"
      And I should see "Edit"
      And I should see "Delete"
    When I follow "Test buddy walk"
    Then I should be on the buddy walk page
      And I should see "Test buddy walk"
      And I should see "May 14, 2014"
      And I should see "Edit"
      And I should see "Delete"
      And I should see "Back"
      And I should see "A big park"
      And I should see "FUN FUN"
      And I should not see "<h1>FUN FUN</h1>"
      And I should not see "Roster"
      And I should not see "Registered Users:"
    When I follow "Back"
    Then I should be on the buddy walks page
  }
end

Given(/^a buddy walk is created$/) do
  steps %{
    When I create a new buddy walk
    Then I should see this new buddy walk
  }
end

When(/^I click on a buddy walk$/) do
  steps %{
    Then I should see "Test buddy walk"
    When I follow "Test buddy walk"
    Then I should see "FUN FUN"
      And I should not see "<h1>FUN FUN</h1>"
  }
end

Then(/^I should not see a buddy slot$/) do
  steps %{
    Then I should not see "Registered Users:"
      And I should not see "Roster"
  }
end

Then(/^I should see this new buddy slot$/) do
  steps %{
    Then I should see "09:00 AM -- 02:00 PM"
      And I should see "Registered Users:"
      And I should see "Roster"
  }
end

When(/I create a buddy slot$/) do
  steps %{
    When I am on the buddy walks page
    Then I should see "Add new Registration Deal"
      And I should see "Change Buddy Walk Schedule"
      And I should see "Add time slot to buddy walk"
    When I follow "Add time slot to buddy walk"
    Then I should be on the add buddy slot page
      And I fill in "Start Time" with "9:00 AM"
      And I fill in "End Time" with "2:00 PM"
    When I press "Submit"
    Then I should be on the buddy walks page
      And I should see "Add new Registration Deal"
      And I should see "Change Buddy Walk Schedule"
      And I should see "Change time slot of buddy walk"
      And I should not see "Add time slot to buddy walk"
      And I should not see "Schedule Buddy Walk Event"
    When I follow "Test buddy walk"
    Then I should be on the buddy walk page
      And I should see this new buddy slot
      And I follow "Back"
  }
end

Given(/an admin created a buddy slot$/) do 
 steps %{
  Given I am login as an admin                
    And I visit the buddy walks page
    And I create a buddy slot
  Then I logout as an admin
 }
end

Given(/^an admin created a buddy walk for search$/) do
  steps %{
    Given I am login as an admin                
          And I am on the buddy walks page
      Then an buddy walk for search is created
        And I logout as an admin
  }
end

Given(/^an admin creates a buddy walk$/) do
  steps %{
    Given I am login as an admin                
      And I visit the buddy walks page
    When I create a new buddy walk
    Then I should see this new buddy walk
      And I logout as an admin
  }
end

Given(/^an admin creates another buddy walk$/) do
  steps %{
    Given I am login as an admin                
      And I visit the buddy walks page
    When I create another buddy walk
    Then I should see both buddy walks with the same date
      And I logout as an admin
  }
end

Given(/^an user registers for this buddy walk$/) do
  steps %{
    Given I am login as an user
        And I am on the buddy walk page
    Then I should see "Register"
    When I follow "Register"
    Then I should be on my registrations page
        And I should see "Test buddy walk"
    When I follow "Test buddy walk"
    Then I should be on the buddy walk page
        And I should see "Registered"
        And I should see "Unregister"
        And I logout as an user
  }
end

Then(/^the correct date is shown on buddy walks$/) do
  steps %{
    Then I should be on the buddy walks page
      And I should see "May 14, 2014"
  }
end

When(/^I create another buddy walk$/) do
  steps %{
    Then I should be on the buddy walks page
      And I should see "Add new Registration Deal"
      And I should not see "Schedule Buddy Walk Event"
    When I follow "Add new Registration Deal"
    Then I should be on the schedule buddy walk page
      And I fill in "Title" with "Another Deal"
      And I fill in "Description" with "<h1>YAY YAY</h1>"
      And I should not see "Location"
      And I should not see "Date"
    When I press "Create new registration deal"
    Then I should be on the buddy walk page with id 2
      And I should see "Another Deal"
      And I should see "May 14, 2014"
      And I should see "Edit"
      And I should see "Delete"
      And I should see "YAY YAY"
      And I should see "A big park"
    When I follow "Back"
    Then I should be on the buddy walks page
      And I should see "Test buddy walk"
      And I should see "Another Deal"
      And I should see "May 14, 2014" 2 times
      And I should see "Edit" 2 times
      And I should see "Delete" 2 times
      And I should see "Add new Registration Deal"
      And I should see "Change Buddy Walk Schedule"
      And I should not see "Schedule Buddy Walk Event"
  }
end

Then(/^I should see both buddy walks with the same date$/) do
  steps %{
    Then I should be on the buddy walks page
      And I should see "Test buddy walk"
      And I should see "Another Deal"
      And I should see "May 14, 2014" 2 times
      And I should see "Edit" 2 times
      And I should see "Delete" 2 times
    When I follow "Another Deal"
    Then I should be on the buddy walk page with id 2
      And I should see "Another Deal"
      And I should see "May 14, 2014"
      And I should see "Edit"
      And I should see "Delete"
      And I should see "Back"
      And I should see "A big park"
      And I should see "YAY YAY"
      And I should not see "<h1>YAY YAY</h1>"
    When I follow "Back"
    Then I should be on the buddy walks page
  }
end

When(/^I change the buddy walk schedule$/) do
  steps %{
    When I am on the buddy walks page
      And I follow "Change Buddy Walk Schedule"
    Then I should be on the edit schedule buddy walk page
      And I fill in "Date" with "March 15, 2014"
      And I fill in "Location" with "Denver"
    When I press "Save"
    Then I should be on the buddy walks page
  }
end

Then(/^I should see that the schedule changed$/) do
  steps %{
    When I am on the buddy walks page
    Then I should see "Test buddy walk"
    When I follow "Test buddy walk"
    Then I should be on the buddy walk page
      And I should see "March 15, 2014"
      And I should see "Denver"
      And I should not see "May 14, 2014"
      And I should not see "A big park"
  }
end

Then(/^I should see that the time change$/) do
  steps %{
    Then I should see "10:00 AM -- 10:30 AM"
  }
end

Then(/^I change the buddy slot$/) do 
  steps %{
    When I am on the buddy walks page
      And I follow "Change time slot of buddy walk"
    Then I should be on the edit buddy slot page
      And I fill in "Start Time" with "10:00 AM"
      And I fill in "End Time" with "10:30 AM"
    When I press "Submit"
    Then I should be on the buddy walks page
  }
end

Then(/^I should see both buddy walks with the new date$/) do
  steps %{
  Then I should be on the buddy walks page
    And I should see "Test buddy walk"
    And I should see "Another Deal"
    And I should see "March 15, 2014" 2 times
    And I should not see "May 14, 2014"
    And I should see "Edit" 2 times
    And I should see "Delete" 2 times
  When I follow "Another Deal"
  Then I should be on the buddy walk page with id 2
    And I should see "Another Deal"
    And I should see "March 15, 2014"
    And I should not see "May 14, 2014"
    And I should see "Edit"
    And I should see "Delete"
    And I should see "Back"
    And I should see "Denver"
    And I should not see "A big park"
    And I should see "YAY YAY"
    And I should not see "<h1>YAY YAY</h1>"
    And I should not see "Roster"
    And I should not see "Registered Users:"
  When I follow "Back"
  Then I should be on the buddy walks page
}
end
