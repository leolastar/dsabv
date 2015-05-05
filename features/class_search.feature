Feature: Class Search
	In to find classes
	As an admin
	I need a way search for classes

	Scenario: Find class by title
	Given an admin created a class for search
		And I am login as an admin
		And I visit the classes page
	Then I fill in "Enter search" with "Math"
	When I press "Search"
	Then I should be on the classes_search page
		And I should see "Math"
		And I should see "May 12, 2014 - May 14, 2014"
		And I should not see "No matches"

    Scenario: Search returns no results when class title does not exists
    Given an admin created a class for search
		And I am login as an admin
		And I visit the classes page
	Then I fill in "Enter search" with "helloEvent"
	When I press "Search"
	Then I should be on the classes_search page
		And I should not see any results

    Scenario: Find class by location
    Given an admin created a class for search
		And I am login as an admin
		And I visit the classes page
	Then I fill in "Enter search" with "blue"
	When I press "Search"
	Then I should be on the classes_search page
		And I should see "blue"
		And I should see "May 12, 2014 - May 14, 2014"
		And I should not see "No matches"

    Scenario: Search returns no results when class location does not exists
    Given an admin created a class for search
		And I am login as an admin
		And I visit the classes page
	Then I fill in "Enter search" with "casa"
	When I press "Search"
	Then I should be on the classes_search page
		And I should not see any results

    Scenario: Find class by description
    Given an admin created a class for search
		And I am login as an admin
		And I visit the classes page
	Then I fill in "Enter search" with "numbers"
	When I press "Search"
	Then I should be on the classes_search page
		And I should see "numbers"
		And I should see "May 12, 2014 - May 14, 2014"
		And I should not see "No matches"

    Scenario: Search returns no results when class description does have search query  
    Given an admin created a class for search
		And I am login as an admin
		And I visit the classes page
	Then I fill in "Enter search" with "cherries"
	When I press "Search"
	Then I should be on the classes_search page
		And I should not see any results 