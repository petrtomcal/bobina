Feature: Manage products
  In order to manage products
  As an admin
  I want to create, update and destroy products
    
  Background:    
    When I go to path "admin/users/login"
    When I fill form
    And I press "Login"
    Then I should see "Logged as: test@test.cz"
  
  @subdomain  
  Scenario: Create product, update him and then destroy
    When I follow "Products"
    Then I should see "New product"
    When I follow "New product"
    And I fill in the following:
      |product[name]|fillsomekindofproduct|      
      |product[price]|200.01|      
    And I press "Save"
    Then I should see "Product was successfully created. Please upload content for product."
    And I should see "Back"
    When I follow "Back"
    Then I should see "fillsomekindofproduct"
    When I follow "fillsomekindofproduct"
    Then I should see "Product name"
    When I follow "Back"    
    
    #create category
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
    
    #add and delete category from product
    When I follow "Products"    
    Then I should see "fillsomekindofproduct"
    When I follow "fillsomekindofproduct"
    Then I should see "Product name"
    When I follow "Back"
    Then I should see "fillsomekindofproduct"    
    When I follow categories "show_categories" for "fillsomekindofproduct"
    Then I should see "fillsomekindofcategory"
    When I follow product_categories "add_category_to_product" for "fillsomekindofcategory" and "fillsomekindofproduct"
    When I follow product_categories "del_category_from_product" for "fillsomekindofcategory" and "fillsomekindofproduct"
    When I follow "Back" 
    Then I should see "fillsomekindofproduct"
    
    #update product
    When I follow product "edit" for "fillsomekindofproduct"
    And I fill in the following:
      |product[name]|fillsomekindofproductnextnonsens|      
      |product[price]|0.0|    
    And I press "Update"
    Then I should see "Price should be at least more than 0.01"
    And I fill in the following:
      |product[name]|short|      
      |product[price]|0.02|    
    And I press "Update"
    Then I should see "Product was successfully edited."
    Then I should see "short" 
    When I follow product "show" for "short"
    Then I should see "Product name"
    Then I should see "short"
    
    # Destroy category
    When I follow "Categories"
    When I follow category "destroy" for "fillsomekindofcategory"    
    Then I should not see "fillsomekindofcategory"

    # Destroy product 
    When I follow "Products"
    When I follow product "destroy" for "short"    
    Then I should not see "short" 
 