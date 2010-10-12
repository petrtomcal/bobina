class Product < ActiveRecord::Base
  liquid_methods :products

  def products
    Products.all
  end
end