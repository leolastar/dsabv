Feature: Admin's editable text boxs
	In order update the classes page
	As an admin
	I need a way to edit the classes page

	Scenario: Edit text box not visible to visitor                       
    Given I visit the home page
    When I visit the classes page                  
    Then I should see "test 5"
    	And I should not see "Edit Text"
    When I go to the classes edit text page
    Then I should be on the home page

	Scenario: Edit text box not visible to user                      
    Given I am login as an user                
    	And I visit the classes page
    Then I should see "test 5"
    	And I should not see "Edit Text"
    When I go to the classes edit text page
    Then I should be on the home page

    Scenario: Edit text box as admin                       
    Given I am login as an admin                 
    	And I visit the classes page
    Then I should see "test 5"
    When I follow "Edit Text"
    Then I should be on the classes edit text page
        And I fill in "Text" with "<h1>Howdy</h1>"
    When I press "Submit"
    Then I should be on the home page
    When I visit the classes page
    Then I should see "Howdy"
    


