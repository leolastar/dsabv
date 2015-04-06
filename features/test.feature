Feature: Admin's editable text boxs
	In order update the home page
	As an admin
	I need a way to edit the home page

  Scenario: Edit top text box                        
    Given I am on the homepage                  
    	And I am login in as an admin                        
    When I press "Edit Text"
    Then I should be on edit_article


