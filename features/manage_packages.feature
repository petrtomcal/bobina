Feature: Manage packages
  In order to manage packages
  As an admin
  I want to create, update and destroy packages
    
  Background:    
    When I go to path "admin/users/login"
    When I fill form
    And I press "Login"
    Then I should see "Logged as: test@test.cz"
  
  @subdomain  
  Scenario: Create package, update him and then destroy
    When I follow "Packages"
    Then I should see "New package"
    When I follow "New package"
    And I fill in the following:
      |pack[name]|fillsomekindofpackage|      
    And I press "Save"
    Then I should see "Package was successfully created."
    And I should see "fillsomekindofpackage"
    When I follow "fillsomekindofpackage"
    Then I should see "Package name"
    When I follow "Back"
    
    #update package    
    When I follow package "edit" for "fillsomekindofpackage"
    And I fill in the following:
      |pack[name]|fillsomekindofpackagenumber2|   
    And I press "Update"
    Then I should see "Package was successfully edited." 
    Then I should see "fillsomekindofpackagenumber2" 
    When I follow package "show" for "fillsomekindofpackagenumber2"
    Then I should see "Package name"
    Then I should see "fillsomekindofpackagenumber2"

    # Destroy user
    When I follow "Packages"
    When I follow package "destroy" for "fillsomekindofpackagenumber2"    
    Then I should not see "fillsomekindofpackagenumber2"
 