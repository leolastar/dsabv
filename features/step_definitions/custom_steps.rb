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

Given(/^I visit the home page$/) do
	if(Article.find_by_id(1) == nil)
  	Article.create(:text => "test 1", :id => 1)
  	Article.create(:text => "test 2", :id => 2)
  end
  visit path_to("the home page")
end

When(/^I create my account$/) do
	user = User.new
	user.email = "testing2@test.com"
	user.id = 2
  UserMailer.account_activation(user).default_url_options = {:host => "localhost:3000"}
  steps %{
    When I press "Create my account"
  }
end

Given(/^I am login in as an admin$/) do
  steps %{
    Given I visit the home page
    When I am an admin
        And I follow "Log in"
    Then I should be on the login page
        And I fill in "Email" with "admin@admin.com"
        And I fill in "Password" with "password"
    When I press "Login"
    Then I should be on my admin page
  }
end

Given(/^I am login in as an user$/) do
  steps %{
    Given I visit the home page
    When I am a user
        And I follow "Log in"
    Then I should be on the login page
        And I fill in "Email" with "test@test.com"
        And I fill in "Password" with "password"
    When I press "Login"
    Then I should be on my user page
  }
end

When(/^I am a user$/) do
	if(User.find_by_id(2) == nil) 
  	@user = User.create(:admin => false, :id => 2, :activated => true, :name => "test2", :email => "test@test.com", :password => "password", :address => "123 Main St");
  end
end

When(/^I am an admin$/) do
	if(!User.exists?(1))
  	@user = User.create(:admin => true, :id => 1, :activated => true, :name => "test", :email => "admin@admin.com", :password => "password", :address => "123 Main St");
  end
end

