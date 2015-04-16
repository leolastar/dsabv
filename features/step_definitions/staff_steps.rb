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

Then (/^I should see "([^\/]*)" (\d+) times$/) do |regexp, number|
  str = regexp
  number = number.to_i
  number -= 1
  number.times{ |i| str = str + "(.+)" + regexp }
  regexp = Regexp.new(str)
  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

When(/^I follow the second "(.*?)"$/) do |text|
  all(text)[1].click
end

Given(/^I made him a staff member$/) do
	steps %{
		When I follow "add staff role"
	    Then I should be on the users page
	}
end
  #user = User.find_by_id(2)
  #user.staff = true
  #user.save