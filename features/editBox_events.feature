Feature: Admin's editable text boxs
	In order update the events page
	As an admin
	I need a way to edit the events page

	Scenario: Edit text box not visible to visitor                       
    Given I visit the home page
    When I am on the events page              
    Then I should see "test 3"
    	And I should not see "Edit Text"
    When I go to the events edit text page
    Then I should be on the home page

	Scenario: Edit text box not visible to user                      
    Given I am login as an user                
    	And I am on the events page 
    Then I should see "test 3"
    	And I should not see "Edit Text"
    When I go to the events edit text page
    Then I should be on the home page

    Scenario: Edit text box as admin                       
    Given I am login as an admin                 
    	And I am on the events page 
    Then I should see "test 3"
    When I follow "Edit Text"
    Then I should be on the events edit text page
        And I fill in "Text" with "<h1>Howdy</h1>"
    When I press "Submit"
    Then I should be on the home page
    When I go to the events page
    Then I should see "Howdy"
    


