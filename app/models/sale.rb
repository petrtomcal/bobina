class Sale < ActiveRecord::Base
  
  has_many :sales, :through => :sales_products
  has_many :sales_products, :dependent => :destroy
  
  has_many :sales, :through => :sales_packs
  has_many :sales_packs, :dependent => :destroy
  
  class << self
    #info
    def to_sale(_products, _packs)
      debugger
      _products.each{ |p| self.save << p }
    end
  
  end
end
