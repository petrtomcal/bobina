class AddTestData < ActiveRecord::Migration
  def self.up
    Product.create(:name => 'Souboj titanu',
    :category_id => 1,    
    :price => 129.95)
    Product.create(:name => 'Terminator 9 - mozna prijde i kouzelnik',
    :category_id => 1,    
    :price => 39.95)
    Product.create(:name => 'Divokej bill - best of',
    :category_id => 2,    
    :price => 299.95)
    Product.create(:name => 'Resipies for app',
    :category_id => 3,    
    :price => 0.99)
  end

  def self.down
    Product.delete_all
  end
end
