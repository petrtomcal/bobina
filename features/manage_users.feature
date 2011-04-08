Feature: Manage Users
  Login as a admin  
  
  Background:
    When I go to path "/admin/users/login"
    And I fill in the following:
      |email   |test@test.com|
      |password|diplomka          |
    And I press "Login"
    Then I should see "Logged in user: test@test.com"
  
  Scenario: Users list
    Given I have login form
    When I fill email and password
    Then I should see logged user
    
  
  