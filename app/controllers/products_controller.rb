class ProductsController < ApplicationController
  
  def index
    products = Product.all.collect { |p| ProductDrop.new(p.name) }
    debugger
    puts ''
    assigns = {:products => products}
    render_liquid_template 'products/list', assigns, self
  end
  
end
