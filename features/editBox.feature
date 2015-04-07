Feature: Admin's editable text boxs
	In order update the home page
	As an admin
	I need a way to edit the home page

	Scenario: Edit text box not visible to visitor                       
    Given I visit the home page                 
    Then I should see "test 1"
    	And I should see "test 2"
    	And I should not see "Edit Text"
    Then I go to the edit text page
    	And I should be on the home page

	Scenario: Edit text box not visible to user                      
    Given I am login in as an user                
    	And I visit the home page 
    Then I should see "test 1"
    	And I should see "test 2"
    	And I should not see "Edit Text"
    Then I go to the edit text page
    	And I should be on the home page

    Scenario: Edit text box as admin                       
    Given I am login in as an admin                 
    	And I visit the home page 
    Then I should see "test 1"
    	And I should see "test 2"
    When I follow "Edit Text"
    Then I should be on the edit text page
    


