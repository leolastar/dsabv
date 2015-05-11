Feature: Buddy Walk Search
	In to find buddy walks
	As an admin
	I need a way search for buddy walks

	Scenario: Find buddy walks by title
	Given an admin created a buddy walk for search
		And I am login as an admin
		And I visit the buddy walks page
	Then I fill in "Enter search" with "Family"
	When I press "Search"
	Then I should be on the buddywalks_search page
		And I should see "Family"
		And I should see "June 12, 2014"
		And I should not see "No matches"

    Scenario: Search returns no results when buddy walks title does not exists
    Given an admin created a class for search
		And I am login as an admin
		And I visit the buddy walks page
	Then I fill in "Enter search" with "helloEvent"
	When I press "Search"
	Then I should be on the buddywalks_search page
		And I should not see any results

    Scenario: Find buddy walks by location
    Given an admin created a buddy walk for search
		And I am login as an admin
		And I visit the buddy walks page
	Then I fill in "Enter search" with "Anderson"
	When I press "Search"
	Then I should be on the buddywalks_search page
		And I should see "Family"
		And I should see "June 12, 2014"
		And I should not see "No matches"

    Scenario: Search returns no results when buddy walk location does not exists
    Given an admin created a buddy walk for search
		And I am login as an admin
		And I visit the buddy walks page
	Then I fill in "Enter search" with "casa"
	When I press "Search"
	Then I should be on the buddywalks_search page
		And I should not see any results

    Scenario: Find buddy walks by description
    Given an admin created a buddy walk for search
		And I am login as an admin
		And I visit the buddy walks page
	Then I fill in "Enter search" with "walking"
	When I press "Search"
	Then I should be on the buddywalks_search page
		And I should see "Family"
		And I should see "June 12, 2014"
		And I should not see "No matches"

    Scenario: Search returns no results when buddy walk description does have search query  
    Given an admin created a buddy walk for search
		And I am login as an admin
		And I visit the buddy walks page
	Then I fill in "Enter search" with "cherries"
	When I press "Search"
	Then I should be on the buddywalks_search page
		And I should not see any results 