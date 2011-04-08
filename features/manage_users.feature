Feature: Manage Users
  In order Login as a admin  
  As an administrator
  i want to view a list of user  
  
  Background:
    When I go to path "/admin/users/login"
    And I fill in the following:
      |email   |test@test.com|
      |password|diplomka|
    And I press "Login"
    Then I should see "Logged in user: test@test.com"
    When I go to path "/users"
  
  Scenario: Users list
    Given I have login form
    And I fill in email "test@test.com"
    And I fill in password "diplomka"
    And I press "Login"
    Then I should see "Logged in user: test@test.com"
    And I click to user
    Then I should see list of users
  