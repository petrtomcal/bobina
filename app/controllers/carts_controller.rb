class CartsController < ApplicationController
  
  def create_product    
    session[:items]["products"] ||= Hash.new
    session[:items]["products"][params[:id]] ||= 0
    session[:items]["products"][params[:id]] += 1
    redirect_to :controller => "products", :action => "list"
  end
  
  def create_pack
    session[:items]["collection"] ||= Hash.new
    session[:items]["collection"][params[:id]] ||= 0
    session[:items]["collection"][params[:id]] += 1
    redirect_to :controller => "products", :action => "list"
  end  
  
  def destroy_product
    session[:items]["products"][params[:id]] -= 1
    if session[:items]["products"][params[:id]] == 0       
      session[:items]["products"].delete(params[:id])
    end    
    redirect_to :controller => "products", :action => "list"
  end
  
   def destroy_pack
    session[:items]["collection"][params[:id]] -= 1
    if session[:items]["collection"][params[:id]] == 0       
      session[:items]["collection"].delete(params[:id])
    end    
    redirect_to :controller => "products", :action => "list"
  end
  
  def checkout
    @cart = Cart.new
    @sale=to_sale
    redirect_to @cart.paypal_url("http://bobina.eshop.cz:3000/products/empty_cart", @sale.sales_products + @sale.sales_packs)    
  end
    
  def to_sale    
    @sale = Sale.new
    @sale.user_id = session[:user_id]    
    @sale.save
    
    session[:items]["products"].each_pair{ |key,value| 
    @sale.sales_products.create(:product_id => key, :count => value)
     }
    
     session[:items]["collection"].each_pair{ |key,value| 
    @sale.sales_packs.create(:pack_id => key, :count => value)
     }
     
     @sale
  end  
  
end
