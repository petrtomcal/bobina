class CartsController < ApplicationController
  before_filter :session_check, :only => [:checkout]
  
  protect_from_forgery :except => [:create_order]  
  skip_before_filter :verify_authenticity_token, :except => [:create_order]
  
  #info - cart by URL
  def create_order    
    session[:items]["products"] ||= Hash.new
    session[:items]["collection"] ||= Hash.new    
    if params[:type]=="product"
      session[:items]["products"][params[:id]] ||= 0
      session[:items]["products"][params[:id]] += 1
    else
      session[:items]["collection"][params[:id]] ||= 0
      session[:items]["collection"][params[:id]] += 1
    end
    redirect_to :action => "cart"
  end  
  
  def create_product    
    session[:items]["products"] ||= Hash.new
    session[:items]["products"][params[:id]] ||= 0
    session[:items]["products"][params[:id]] += 1    
    redirect_to :controller => "products", :action => "index"
  end
  
  def create_pack
    session[:items]["collection"] ||= Hash.new
    session[:items]["collection"][params[:id]] ||= 0
    session[:items]["collection"][params[:id]] += 1
    redirect_to :controller => "products", :action => "index"
  end  
  
  def destroy_product
    session[:items]["products"][params[:id]] -= 1
    if session[:items]["products"][params[:id]] == 0       
      session[:items]["products"].delete(params[:id])
    end    
    redirect_to :controller => "products", :action => "index"
  end
  
  def destroy_pack
    session[:items]["collection"][params[:id]] -= 1
    if session[:items]["collection"][params[:id]] == 0       
      session[:items]["collection"].delete(params[:id])
    end    
    redirect_to :controller => "products", :action => "index"
  end
  
  #info - rfc
  def cart
    session[:items] ||= Hash.new
    @cart = Cart.new
    session[:items]["products"] ||= Hash.new
    session[:items]["collection"] ||= Hash.new
    
    @sale = to_sale
    notify = url_for :controller => 'payment_notifications', :action => 'create'
    #info - url for empty car - subdomain
    #subdomain = request.host.split(".").first
    user_id = User.find_by_admin("1").id
    setting = Setting.find_by_user_id(user_id)    
    encrypted_PP = @cart.paypal_url("http://bobina.eshop.cz:3000/products/empty_cart", notify,
                                    @sale.sales_products + @sale.sales_packs, @sale.token,    
                                    request.host.split(".").first, setting)
    
    products = Product.all.collect { |p| ProductDrop.new(p) }
    packs = Pack.all.collect { |p| PackDrop.new(p) }
    cart = CartDrop.new(session[:items], encrypted_PP)    
    assigns = {'products' => products, 'cart' => cart, 'packs' => packs}
    assigns = assigns.merge(get_user_hash) if session[:user_id]
    render_liquid_template 'products/cart', assigns, self
  end
 #info - mail delivery  
 #  def checkout
 #    @cart = Cart.new
 #    @sale = to_sale   
 #    
 #    @domain = request.host    
 #    #info - delivery now, downloading after paymant notification
 #    
 #    NotifierUser.deliver_checkout(@sale.user_id, @sale.token, @domain)
 #    notify = url_for :controller => 'payment_notifications', :action => 'create'
 #    redirect_to @cart.paypal_url("http://bobina.eshop.cz:3000/products/empty_cart", notify,                                              #                                   @sale.sales_products + @sale.sales_packs,                                                             #                                    @sale.token)
 #  end  
  
  def to_sale    
    @sale = Sale.new
    @sale.user_id = session[:user_id]
    @sale.token = get_unique_token
    @sale.save
    
    session[:items]["products"].each_pair{ |key,value| 
    @sale.sales_products.create(:product_id => key, :count => value)
     }
    
    session[:items]["collection"].each_pair{ |key,value| 
    @sale.sales_packs.create(:pack_id => key, :count => value)
     }
     
    @sale
  end  
  
  def get_user_hash
    @user = User.find(session[:user_id])
    user = UserDrop.new(@user)
    userhash = {'user' => user}
  end
  
  private
  #info 
  def get_unique_token
    token = rand(36**8).to_s(36) + rand(Time.now).to_s(36)
    letter = ("A".."Z").to_a 
    
    2.times do       
      token.insert(rand(10), letter[rand(25)])
    end
    
    if check_exist(token)    
      get_unique_token
    else
      token
    end    
  end
  
  def check_exist(_token)
    Sale.exists?(:token => _token)
  end
  
end
