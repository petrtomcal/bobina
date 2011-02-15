class Pack < ActiveRecord::Base
  
  has_many :products, :through => :packs_products
  has_many :packs_products, :dependent => :destroy
  
  has_many :categories, :through => :packs_categories
  has_many :packs_categories, :dependent => :destroy
  
  has_many :sales, :through => :sales_packs
  has_many :sales_packs, :dependent => :destroy
  
  attr_accessor :count
  
  #Metoda vrati true pokud ma produkt kategorii
  def has_product?(product_id) 
    tmp = self.products.find(product_id) rescue nil
    return !tmp.nil?
  end

  #Metoda znici vazbu produktu na balik  
  def remove_product(product_id) 
    if self.has_product?(product_id)
      PacksProduct.find_association(self.id, product_id).destroy
      self.reload
    end
  end
  
  def total_price    
    self.products.sum('price')
  end
  
end
