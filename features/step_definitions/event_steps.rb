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

When(/^I create a new event$/) do
  steps %{
    When I follow "Add new event"
    Then I should be on the new event page
        And I fill in "Title" with "Test event"
        And I fill in "Date" with "12/12/2014"
        And I fill in "Location" with "Mi casa"
        And I fill in "Description" with "<h1>howdy</h1>"
    When I press "Create new event"
    Then I should be on the event page
    When I follow "Back"
  }
end

Given(/^an event for search is created$/) do
  steps %{
    When I follow "Add new event"
    Then I should be on the new event page
        And I fill in "Title" with "Flagship"
        And I fill in "Date" with "12/12/2014"
        And I fill in "Location" with "My abode"
        And I fill in "Description" with "Bubbles will be everywhere"
    When I press "Create new event"
    Then I should be on the event page
    When I follow "Back"
  }
end

Then(/^I should see this new event$/) do
  steps %{
    Then I should be on the events page
        And I should see "Test event"
        And I should see "December 12, 2014"
        And I should see "Edit"
        And I should see "Delete"
  }
end

Given(/^an event is created$/) do
  steps %{
    When I create a new event
    Then I should see this new event
  }
end

When(/^I click on an event$/) do
  steps %{
    Then I should see "Test event"
    When I follow "Test event"
    Then I should see "howdy"
      And I should not see "<h1>howdy</h1>"
  }
end

Then(/^I should not see an timeslot$/) do
  steps %{
    Then I should not see "Available slots"
        And I should not see "out of"
  }
end

Then(/^I should see this new timeslot$/) do
  steps %{
    Then I should be on the event page
        And I should see "9:00 AM"
        And I should see "9:50 AM"
        And I should see "Available slots"
  }
end

When(/I create a timeslot$/) do
  steps %{
    When I follow "Add time slot"
    Then I should be on the add time slot page
        And I fill in "Start Time" with "9:00"
        And I fill in "End Time" with "9:50"
        And I fill in "Capacity" with "15"
    When I press "Submit"
  }
end

Given(/an admin created an event$/) do 
  steps %{
    Given I am login as an admin                
          And I am on the events page
          And an event is created
      Then I logout as an admin
  }
end

Given(/^an admin created an event for search$/) do
  steps %{
    Given I am login as an admin                
          And I am on the events page
          And an event for search is created
      Then I logout as an admin
  }
end

Given(/^an admin creates a timeslot$/) do
  steps %{
    Given I am login as an admin                
          And I am on the events page
      Then I follow "Test event"
        And I create a timeslot
        And I logout as an admin
  }
end

Given(/^an user registers the event$/) do
  steps %{
    Given I am login as an user
        And I am on the event page
    Then I should see "Register"
    When I follow "Register"
    Then I should be on my registrations page
        And I should see "Test event"
    When I follow "Test event"
    Then I should be on the event page
        And I should see "Registered"
        And I logout as an user
  }
end

Then(/^I should see the event$/) do
  steps %{
    Then I should be on the events page
      And I should see "Test event"
      And I should see "December 12, 2014"
  }
end

Then(/^the correct date is shown$/) do
  steps %{
    Then I should be on the events page
      And I should see "December 12, 2014"
  }
end

Given(/^an user registers for this event$/) do
  steps %{
    Given I am on the event page
    Then I should see "Register"
    When I follow "Register"
    Then I should be on my registrations page
        And I should see "Test event"
    When I follow "Test event"
    Then I should be on the event page
        And I should see "Registered"
        And I should see "Unregister"
  }
end