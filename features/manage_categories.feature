Feature: Manage categories
  In order to manage categories
  As an admin
  I want to create, update and destroy categories
    
  Background:    
    When I go to path "admin/users/login"
    When I fill form
    And I press "Login"
    Then I should see "Logged as: test@test.cz"
  
  @subdomain  
  Scenario: Create Category, update him and then destroy
    When I follow "Categories"
    Then I should see "New category"
    When I follow "New category"
    And I fill in the following:
      |category[name]|fillsomekindofcategory|      
    And I press "Save"
    Then I should see "Category was successfully created."
    And I should see "fillsomekindofcategory"
    When I follow "fillsomekindofcategory"
    Then I should see "Category name"
    When I follow "Back"
    
    #update category    
    When I follow category "edit" for "fillsomekindofcategory"
    And I fill in the following:
      |category[name]|fillsomekindofcategorynumber2|   
    And I press "Update"
    Then I should see "Category was successfully edited." 
    Then I should see "fillsomekindofcategorynumber2" 
    When I follow category "show" for "fillsomekindofcategorynumber2"
    Then I should see "Category name"
    Then I should see "fillsomekindofcategorynumber2"

    # Destroy user
    When I follow "Categories"
    When I follow category "destroy" for "fillsomekindofcategorynumber2"    
    Then I should not see "fillsomekindofcategorynumber2"
 