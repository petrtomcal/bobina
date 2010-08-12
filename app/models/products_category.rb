class ProductsCategory < ActiveRecord::Base
  
  belongs_to :product
  belongs_to :category
  
  def self.find_association(category_id, product_id)
    return self.find(:first, :conditions => ["category_id = ? AND product_id = ?", category_id, product_id])
  end
  
end
