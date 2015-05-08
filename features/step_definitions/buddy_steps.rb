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

# When(/^I create a new buddy walk$/) do
#   steps %{
#   }
# end

# Given(/^an buddy walk for search is created$/) do
#   steps %{
#   }
# end

# Then(/^I should see this new buddy walk$/) do
#   steps %{
#   }
# end

# Given(/^an buddy walk is created$/) do
#   steps %{
#   }
# end

# When(/^I click on an buddy walk$/) do
#   steps %{
#   }
# end

# Then(/^I should not see an buddy slot$/) do
#   steps %{
#   }
# end

# Then(/^I should see this new buddy slot$/) do
#   steps %{
#   }
# end

# When(/I create a buddy slot$/) do
#   steps %{
#   }
# end

# Given(/an admin created an buddy slot$/) do 
#   steps %{
#   }
# end

# Given(/^an admin created an buddy walk for search$/) do
#   steps %{
#     Given I am login as an admin                
#           And I am on the buddy walks page
#           And an buddy walk for search is created
#       Then I logout as an admin
#   }
# end

# Given(/^an admin creates a timeslot$/) do
#   steps %{
#     Given I am login as an admin                
#           And I am on the buddy walks page
#       Then I follow "Test buddy walk"
#         And I create a buddy slot
#         And I logout as an admin
#   }
# end

# Given(/^an user registers for the buddy walk$/) do
#   steps %{
#     Given I am login as an user
#         And I am on the buddy walk page
#     Then I should see "Register"
#     When I follow "Register"
#     Then I should be on my registrations page
#         And I should see "Test buddy walk"
#     When I follow "Test buddy walk"
#     Then I should be on the buddy walk page
#         And I should see "Registered"
#         And I should see "Unregister"
#         And I logout as an user
#   }
# end

# Then(/^I should see the buddy walk$/) do
#   steps %{
#     Then I should be on the buddy walks page
#       And I should see "Test buddy walk"
#       And I should see "May 14, 2014"
#   }
# end

# Then(/^the correct date is shown$/) do
#   steps %{
#     Then I should be on the buddy walks page
#       And I should see "May 14, 2014"
#   }
# end

# Given(/^an user registers for this event$/) do
#   steps %{
#     Given I am on the buddy walk page
#     Then I should see "Register"
#     When I follow "Register"
#     Then I should be on my registrations page
#         And I should see "Test buddy walk"
#     When I follow "Test buddy walk"
#     Then I should be on the buddy walk page
#         And I should see "Registered"
#         And I should see "Unregister"
#   }
# end