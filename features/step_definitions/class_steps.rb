require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end

When(/^I create a new class$/) do
  steps %{
    When I follow "Add new class"
    Then I should be on the new ds class page
        And I fill in "Title" with "Test class"
        And I fill in "Start Date" with "December 25, 2014"
        And I fill in "End Date" with "December 30, 2014"
        And I fill in "Location" with "A classroom"
        And I fill in "Description" with "<h1>howdy</h1>"
    When I press "Create new class"
    Then I should be on the class page
    When I follow "Back"
  }
end

Given(/^an admin created a class$/) do
  steps %{
    Given I am login as an admin                
          And I visit the classes page
          And an class is created
      Then I logout as an admin
  }
end

Given(/^an user registers for this class$/) do
  steps %{
    Given I am login as an user
      And I visit the classes page
    When I follow "Test class"
    Then I should see "Register"
    When I follow "Register"
    Then I should be on my registrations page
        And I should see "Test class"
    When I follow "Test class"
    Then I should be on the class page
        And I should see "Registered"
        And I logout as an user
  }
end

When(/^I click on a class$/) do
  steps %{
    Then I should see "Test class"
    When I follow "Test class"
    Then I should see "howdy"
      And I should not see "<h1>howdy</h1>"
  }
end


Given(/^a class for search is created$/) do
  steps %{
    When I follow "Add new class"
    Then I should be on the new ds class page
        And I fill in "Title" with "Math class"
        And I fill in "Start Date" with "May 12, 2014"
        And I fill in "End Date" with "May 14, 2014"
        And I fill in "Location" with "The blue room"
        And I fill in "Description" with "Numbers will be everywhere"
    When I press "Create new class"
    Then I should be on the class page
    When I follow "Back"
  }
end

Given(/^an admin created a class for search$/) do
  steps %{
    Given I am login as an admin                
          And I visit the classes page
          And a class for search is created
      Then I logout as an admin
  }
end

Then(/^I should see this new class$/) do
  steps %{
    Then I should be on the ds classes page
        And I should see "Test class"
        And I should see "December 25, 2014 - December 30, 2014"
        And I should see "Edit"
        And I should see "Delete"
  }
end

Given(/^an class is created$/) do
  steps %{
    When I create a new class
    Then I should see this new class
  }
end

When(/^I click on an class$/) do
  steps %{
    Then I should see "Test class"
    When I follow "Test class"
    Then I should see "howdy"
      And I should not see "<h1>howdy</h1>"
  }
end

Then(/^I should not see an class slot$/) do
  steps %{
    Then I should not see "Available slots"
        And I should not see "out of"
  }
end

When(/^I create a class slot$/) do
  steps %{
    When I follow "Add time slot"
    Then I should be on the add class slot page
        And I fill in "Start Time" with "9:00"
        And I fill in "End Time" with "9:50"
        And I fill in "Capacity" with "15"
    When I press "Submit"
  }
end

Then(/^I should see this new class slot$/) do
  steps %{
    Then I should be on the class page
        And I should see "9:00 AM"
        And I should see "9:50 AM"
        And I should see "Available slots"
  }
end

Given(/^an admin created an class$/) do
  steps %{
    Given I am login as an admin                
          And I visit the classes page
          And an class is created
      Then I logout as an admin
  }
end

Given(/^an admin creates a class slot$/) do
  steps %{
    Given I am login as an admin                
          And I visit the classes page
      Then I follow "Test class"
        And I create a class slot
        And I logout as an admin
  }
end

Then(/^I should see the class$/) do
  steps %{
    Then I should be on the ds classes page
      And I should see "Test class"
      And I should see "December 25, 2014 - December 30, 2014"
  }
end

Then(/^the correct date is shown on classes$/) do
  steps %{
    Then I should be on the ds classes page
      And I should see "December 25, 2014 - December 30, 2014"
  }
end

