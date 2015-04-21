Feature: User Search
	In to find users
	As an admin
	I need a way search for users

	Scenario: Find user by name
	Given I am login as an admin
        And an user for search is signed up
        And I am on the users page
    Then I fill in "Enter search" with "test2"
	When I press "Search"
	Then I should be on the users_search page
		And I should see "test2"
		And I should see "test@test.com"
		And I should not see "No matches"

    Scenario: Search returns no results when user has this name
    Given I am login as an admin
        And an user for search is signed up
        And I am on the users page
    Then I fill in "Enter search" with "tommy"
	When I press "Search"
	Then I should be on the users_search page
		And I should not see any results


    Scenario: Find user by email
    Given I am login as an admin
        And an user for search is signed up
        And I am on the users page
    Then I fill in "Enter search" with "test@test.com"
	When I press "Search"
	Then I should be on the users_search page
		And I should see "test2"
		And I should see "test@test.com"
		And I should not see "No matches"

    Scenario: Search returns no results when user with this email does not exists
    Given I am login as an admin
        And an user for search is signed up
        And I am on the users page
    Then I fill in "Enter search" with "test@poop.com"
	When I press "Search"
	Then I should be on the users_search page
		And I should not see any results

	Scenario: Find user with part of the word
	Scenario: Find user by name
	Given I am login as an admin
        And an user for search is signed up
        And I am on the users page
    Then I fill in "Enter search" with "test"
	When I press "Search"
	Then I should be on the users_search page
		And I should see "test2"
		And I should see "test@test.com"
		And I should not see "No matches"
