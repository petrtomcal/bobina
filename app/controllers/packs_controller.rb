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
    p = Packs.find_by_id(params[:id])
    pack = PackDrop.new(p.name, p.category_id, p.price, p.attachments, p.id)
    assigns = {'pack' => pack, 'cart' => cart}
    render_liquid_template 'products/show', assigns, self
  end
  
end
