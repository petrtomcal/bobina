class Product < ActiveRecord::Base
  
  has_many :categories, :through => :products_categories
  has_many :products_categories, :dependent => :destroy
  
  has_many :packs, :through => :packs_products
  has_many :packs_products, :dependent => :destroy
    
end
