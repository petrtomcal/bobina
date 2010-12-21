class CartsController < ApplicationController
  
  def create    
    session[:items] ||= Hash.new
    session[:items][params[:id]] ||= 0
    session[:items][params[:id]] += 1
    redirect_to :controller => "products", :action => "list"
  end
  
  
  def destroy
    session[:items][params[:id]] -= 1
    if session[:items][params[:id]] == 0       
      session[:items].delete(params[:id])
    end    
    redirect_to :controller => "products", :action => "list"
  end
  
  def checkout
    @cart = Cart.new
    @items ||= []    
    session[:items].each_pair{ |key,value| @items << [Product.find(key), value] }
    redirect_to @cart.paypal_url("http://bobina.eshop.cz:3000/products/list", @items)
  end
  
end
