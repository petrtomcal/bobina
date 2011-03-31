class Product < ActiveRecord::Base
  
  has_many :categories, :through => :products_categories
  has_many :products_categories, :dependent => :destroy
  
  has_many :packs, :through => :packs_products
  has_many :packs_products, :dependent => :destroy
  
  has_many :attachments, :dependent => :destroy
  
  has_many :sales, :through => :sales_products
  has_many :sales_products, :dependent => :destroy
  
  validates_presence_of :name, :message => "can't be blank"
  validates_numericality_of :price, :message => "is not a number"
  validate :price_must_be_at_least_0
  
  
  attr_accessor :count  
    
  protected
  def price_must_be_at_least_0
    errors.add(:price, 'should be at least more than 0.01') if price.nil? || price < 0.01 
  end                    
        
end
