class ProductsController < ApplicationController
  
  def index
    session[:items] ||= Hash.new
    list
  end
  
  def list
    #reset_session #info
    session[:items]["products"] ||= Hash.new
    session[:items]["collection"] ||= Hash.new
    products = Product.all.collect { |p| ProductDrop.new(p) }
    packs = Pack.all.collect { |p| PackDrop.new(p) }
    cart = CartDrop.new(session[:items])
    assigns = {'products' => products, 'cart' => cart, 'packs' => packs}
    render_liquid_template 'products/list', assigns, self       
  end
  
  def show    
    p = Product.find_by_id(params[:id])
    product = ProductDrop.new(p.name, p.category_id, p.price, p.attachments, p.id)
    assigns = {'product' => product, 'cart' => cart}
    render_liquid_template 'products/show', assigns, self
  end
  
end
