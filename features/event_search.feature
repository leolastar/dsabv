Feature: Event Search
	In to find events
	As an admin
	I need a way search for events

	Scenario: Find event by title
	Given an admin created an event for search
		And I am login as an admin
		And I am on the events page
	Then I fill in "Enter search" with "Flagship"
	When I press "Search"
	Then I should be on the events_search page
		And I should see "Flagship"

    Scenario: Search returns no results when event title does not exists
    Given an admin created an event for search
		And I am login as an admin
		And I am on the events page
	Then I fill in "Enter search" with "helloEvent"
	When I press "Search"
	Then I should be on the events_search page
		And I should not see any results

    Scenario: Find event by location
    Given an admin created an event for search
		And I am login as an admin
		And I am on the events page
	Then I fill in "Enter search" with "abode"
	When I press "Search"
	Then I should be on the events_search page
		And I should see "abode"

    Scenario: Search returns no results when event location does not exists
    Given an admin created an event for search
		And I am login as an admin
		And I am on the events page
	Then I fill in "Enter search" with "casa"
	When I press "Search"
	Then I should be on the events_search page
		And I should not see any results

    Scenario: Find event by description
    Given an admin created an event for search
		And I am login as an admin
		And I am on the events page
	Then I fill in "Enter search" with "bubbles"
	When I press "Search"
	Then I should be on the events_search page
		And I should see "bubbles"

    Scenario: Search returns no results when event description does have search query  
    Given an admin created an event for search
		And I am login as an admin
		And I am on the events page
	Then I fill in "Enter search" with "cherries"
	When I press "Search"
	Then I should be on the events_search page
		And I should not see any results 