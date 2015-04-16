# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home page/
      then root_path
    when /the edit text page/
      then edit_article_path(:id => 1)
    when /the login page/
      then login_path
    when /my user page/
      then user_path(:id => 2)
    when /my admin page/
      then user_path(:id => 1)
    when /the event page/
      then "/events/1"
    when /the add time slot page/
      then add_time_slot_to_event_path(1)
    when /the events roster/
      then roster_of_event_path(1)
    when /my registrations page/
      then registrations_user_path(2)

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
