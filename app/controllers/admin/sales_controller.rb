class Admin::SalesController < ApplicationController
  
  def index
    @sale = Sale.new
  end
  
  def graph
    @sale = get_data
    @counts_sales_group ||= []
    @sale.each {|key, value|  @counts_sales_group << value.size }    
  end
  
  def get_data    
    if user_id
     @sale = Sale.find(:all, :conditions => { :created_at => start_date..end_date, :user_id => user_id }, 
         :order =>  "created_at").group_by{ |sale| sale.created_at.strftime("(%y/%d/%m)") }    
    end
    if pack_id
      @sale = Sale.find(:all, :conditions => { :created_at => start_date..end_date, :pack_id => pack_id }, 
          :order =>  "created_at").group_by{ |sale| sale.created_at.strftime("(%y/%d/%m)") }
          
    end            
    if product_id
      @sale = Sale.find(:all, :conditions => { :created_at => start_date..end_date, :product_id => product_id }, 
          :order =>  "created_at").group_by{ |sale| sale.created_at.strftime("(%y/%d/%m)") }
    end      
    
  end  
  
  def start_date
    @start_date = DateTime.civil(params[:st][:"start_date(1i)"].to_i,     
                                  params[:st][:"start_date(2i)"].to_i,
                                  params[:st][:"start_date(3i)"].to_i, 
                                  params[:st][:"start_date(4i)"].to_i,
                                  params[:st][:"start_date(5i)"].to_i)  
  end
  
  def end_date
    @end_date = DateTime.civil(params[:et][:"end_date(1i)"].to_i, 
                                params[:et][:"end_date(2i)"].to_i, 
                                params[:et][:"end_date(3i)"].to_i, 
                                params[:et][:"end_date(4i)"].to_i, 
                                params[:et][:"end_date(5i)"].to_i)  
  end
  
  def product_id
    @product_id = params["products"]["id"] 
  end
  
  def pack_id
    @pack_id = params["packs"]["id"] 
  end
  
  def user_id
    @user_id = params["users"]["id"] 
  end
end
