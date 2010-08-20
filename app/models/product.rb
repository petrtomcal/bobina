class Product < ActiveRecord::Base
  
  has_many :categories, :through => :products_categories
  has_many :products_categories, :dependent => :destroy
  
  has_many :packs, :through => :packs_products
  has_many :packs_products, :dependent => :destroy
  
  has_many :attachments
  
  validates_presence_of :name, :message => "can't be blank"
  
  
  has_attached_file :attachment,
                    :path => ":rails_root/public/product/:id/:style/:basename.:extension"
        
end
