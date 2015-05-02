Feature: Admin's editable text boxs
	In order update the buddy walk page
	As an admin
	I need a way to edit the buddy walk page

	Scenario: Edit text box not visible to visitor                       
    Given I visit the home page
    When I visit the buddy walk page                
    Then I should see "test 4"
    	And I should not see "Edit Text"
    When I go to the buddy walk edit text page
    Then I should be on the home page

	Scenario: Edit text box not visible to user                      
    Given I am login as an user                
    	And I visit the buddy walk page
    Then I should see "test 4"
    	And I should not see "Edit Text"
    When I go to the buddy walk edit text page
    Then I should be on the home page

    Scenario: Edit text box as admin                       
    Given I am login as an admin                 
    	And I visit the buddy walk page
    Then I should see "test 4"
    When I follow "Edit Text"
    Then I should be on the buddy walk edit text page
        And I fill in "Text" with "<h1>Howdy</h1>"
    When I press "Submit"
    Then I should be on the home page
    When I visit the buddy walk page
    Then I should see "Howdy"
    


