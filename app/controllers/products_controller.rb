class ProductsController < ApplicationController
  before_filter :session_check
  
  #def index
  #  session[:items] ||= Hash.new
  #  @cart = Cart.new
  #  list
  #end
  
  def index
    session[:items] ||= Hash.new
    @cart = Cart.new
    session[:items]["products"] ||= Hash.new
    session[:items]["collection"] ||= Hash.new
    products = Product.all.collect { |p| ProductDrop.new(p) }
    packs = Pack.all.collect { |p| PackDrop.new(p) }
    cart = CartDrop.new(session[:items])    
    unless @user == nil
       user = UserDrop.new(@user) 
    end
    assigns = {'products' => products, 'cart' => cart, 'packs' => packs, 'user' => user}
    render_liquid_template 'products/list', assigns, self    
  end
  
  def show
    p = Product.find_by_id(params[:id])
    product = ProductDrop.new(p, nil)
    assigns = {'product' => product}
    render_liquid_template 'products/show', assigns, self
  end
  
  def empty_cart
    session[:items]["products"] = Hash.new
    session[:items]["collection"] = Hash.new
    index    
  end
  
  #info - rfc
  def sale_history_list
    if @user == nil
      redirect_to :action => 'list'
    else
      sales = Sale.find(:all, :conditions => { :user_id => @user.id })    
      times = sales.size    
      sales.each {|s|    
      if times == sales.size
        @products = s.products.collect { |p| ProductDrop.new(p) }
        @packs = s.packs.collect { |p| PackDrop.new(p) }
      else       
        @products = @products + s.products.collect { |p| ProductDrop.new(p) }
        @packs = @packs + s.packs.collect { |p| PackDrop.new(p) }     
      end
      times =- 1
      }    
      unless @user == nil
         user = UserDrop.new(@user) 
      end
      assigns = {'products' => @products, 'packs' => @packs, 'user' => user}
      render_liquid_template 'products/sale_history_list', assigns, self
    end    
  end
  
end
