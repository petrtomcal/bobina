class CartsController < ApplicationController
  before_filter :session_check, :only => [:checkout]
  
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
  
  def checkout#info just logged
    @cart = Cart.new
    @sale = to_sale   
    
    @domain = request.host    
    NotifierUser.deliver_checkout(@sale.user_id, @sale.token, @domain)
    notify = url_for :controller => 'payment_notifications', :action => 'create'
    redirect_to @cart.paypal_url("http://bobina.eshop.cz:3000/products/empty_cart", notify,
                                 @sale.sales_products + @sale.sales_packs,
                                 @sale.token) 
  end  
  
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
