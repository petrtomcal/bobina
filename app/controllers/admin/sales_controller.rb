class Admin::SalesController < ApplicationController
  
  def index
    @sale = Sale.new
  end
  
  def products_by_user
    @sale = Sale.find(:all, :conditions => { :created_at => start_date..end_date}, 
          :order =>  "created_at").group_by{ |sale| sale.created_at.strftime("(%y/%d/%m)") }
    @counts_sales_group ||= []
    @sale.each {|key, value|  @counts_sales_group << value.size }
    @one_point = @counts_sales_group.max/@sale.keys.size
    @y_label ||= []
    @sale.keys.size.times do |x|
      @y_label << @one_point * x
    end    
    @y_label << @counts_sales_group.max
    
  end
  
  def pack_by_user
    
  end
  
  def user_in_time
    
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
    @pack_id = params["pack"]["id"] 
  end
  
  def user_id
    @user_id = params["user"]["id"] 
  end
end
