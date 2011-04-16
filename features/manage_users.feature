Feature: Manage Users
  In order to manage users
  As an admin
  I want to create, update and destroy user
    
  Background:    
    When I go to path "admin/users/login"
    When I fill form
    And I press "Login"
    Then I should see "Logged as: test@test.cz"
  
  @subdomain
  Scenario: Users List
    When I follow "Users"
    Then I should see "Logged as: test@test.cz"
    And I click to users
    When I follow "test@test.cz"
    Then I should see "User detail"
  
  @subdomain  
  Scenario: Create User, update him and then destroy
    When I follow "New user"
    And I fill in the following:
      |user[email]                    |test@go2time.com|      
    And I press "Save"
    Then I should see "User was successfully created."
    And I should see "test@go2time.com"
    
    #update diff user?
    When I follow "edit" for "test@go2time.com"
    And I fill in the following:
      |user[email]                    |yeap@yeap.com|   
    And I press "Update"
    Then I should see "yeap@yeap.com" 
    When I follow "show" for "yeap@yeap.com"
    Then I should see "User detail"
    Then I should see "yeap@yeap.com"

    # Destroy user
    When I follow "Users"
    When I follow "destroy" for "yeap@yeap.com"
    #And a confirmation box saying "Are you sure?" should pop up
    #And I want to click "Ok"
    #Then I should see "Are you sure?"
    #And I press "Ok"
    Then I should not see "yeap@yeap.com"
 