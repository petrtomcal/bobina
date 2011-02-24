class PacksController < ApplicationController
  
  def index
    list
  end
  
  def list
    packs = Pack.all.collect { |p| PackDrop.new(p) }
    session[:items] ||= Hash.new
    cart = CartDrop.new(session[:items])
    assigns = {'packs' => packs, 'cart' => cart}
    render_liquid_template 'products/list', assigns, self    
  end
  
  def show    
    p = Pack.find_by_id(params[:id])
    pack = PackDrop.new(p, nil)
    products = p.products.all.collect { |p| ProductDrop.new(p) }        
    assigns = {'pack' => pack, 'products' => products}
    render_liquid_template 'packs/show', assigns, self    
  end
  
end
