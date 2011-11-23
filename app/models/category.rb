class Category < ActiveRecord::Base
  
  has_many :products, :through => :products_categories
  has_many :products_categories, :dependent => :destroy  
  
  validates_presence_of :name, :message => "can't be blank."
  validates_uniqueness_of :name, :message => 'must be unique. This is already used.'
  
  def has_product?(product_id) 
    tmp = self.products.find(product_id) rescue nil
    return !tmp.nil?
  end

  def remove_product(product_id) 
    if self.has_product?(product_id)
      ProductsCategory.find_association(self.id, product_id).destroy
      self.reload
    end
  end
  
end
