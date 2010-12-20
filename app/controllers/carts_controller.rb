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
  
end
