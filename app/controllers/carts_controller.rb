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
    @items ||= []    
    @product_items ||= []
    @pack_items ||= []
    session[:items]["products"].each_pair{ |key,value| @product_items << [Product.find(key), value] }
    session[:items]["collection"].each_pair{ |key,value| @pack_items << [Pack.find(key), value] }    
    to_sale_products(@product_items)
    to_sale_collections(@pack_items)
    #Sale.to_sale(@product_items, @pack_items) #info
    @items = @product_items + @pack_items
    redirect_to @cart.paypal_url("http://bobina.eshop.cz:3000/products/list", @items)
  end
  
  def to_sale_products(array)
    array.each_with_index do |item,index|
      @product = item[0]
      @sale = Sale.new
      #@sale.product = @product
      @sp = SalesProducts.new
      @sp.product = @product
      @sp.count = item[1]
      @sp.sale = @sale
      @sale.name = @product.name
      @sale.product_id = @product.id
      @sp.save      
      @sale.save
    end
  end
  
  def to_sale_collections(array)
    array.each_with_index do |item,index|
      @pack = item[0]
      @sale = Sale.new
      #@sale.product = @product
      @sp = SalesPacks.new
      @sp.pack = @pack
      @sp.sale = @sale
      @sp.count = item[1]
      @sale.name = @pack.name
      @sale.pack_id = @pack.id
      @sp.save      
      @sale.save
    end
  end
  
end
