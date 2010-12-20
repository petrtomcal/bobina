class ProductsController < ApplicationController
  
  def index
    list
  end
  
  def list
    products = Product.all.collect { |p| ProductDrop.new(p) }
    session[:items] ||= Hash.new
    cart = CartDrop.new(session[:items])
    assigns = {'products' => products, 'cart' => cart}
    render_liquid_template 'products/list', assigns, self    
  end
  
  def show    
    p = Product.find_by_id(params[:id])
    product = ProductDrop.new(p.name, p.category_id, p.price, p.attachments, p.id)
    assigns = {'product' => product, 'cart' => cart}    
    debugger
    render_liquid_template 'products/show', assigns, self
  end
  
end
