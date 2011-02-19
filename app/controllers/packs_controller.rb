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
    
    #products_id = PacksProduct.find(:all, :select => "product_id", :conditions => ["pack_id = ?", params[:id]])
    products = p.products.all.collect { |p| ProductDrop.new(p) }        
    assigns = {'pack' => pack, 'products' => products}
    render_liquid_template 'packs/show', assigns, self
    
    
    #galleries_group = GalleriesGroup.find(:all, :conditions => ["group_id IN (?)", groups_id])
    #galleries_id_group = galleries_group.collect{|p| p.gallery_id}#id galerii z vybranych skupiny
    #galleries_id = galleries_id_user + galleries_id_group
  end
  
end
