class Admin::SalesController < ApplicationController
  before_filter :check_authentication
  
  def index
    @sale = Sale.new
  end
  #info collection to stats
  def graph      
      begin    
      @sale = Sale.all( :conditions => { :created_at => start_date..end_date }, :joins => [:sales_products], :select => "sales.*, sum(  sales_products.count) as products_count", :group => "sales.id").group_by{ |sale| sale.created_at.strftime("(%y/%d/%m)") }     
      @counts_sales_group ||= []
      @sale.each {|key, value| 
        @counts_sales_group << value.map { |s| s.products_count.to_i }.sum     
      }            
      get_size
      rescue
        flash[:warning] = ('Bad range, from '+start_date.to_date.to_s+' to '+end_date.to_date.to_s+' are any data, change range please.')
        redirect_to :controller => 'sales', :action => 'index'        
      end
  end
  
  def get_size
    if ((150 > @counts_sales_group.max) && (@counts_sales_group.max < 200)) && 
      ((0 > @counts_sales_group.size) && (@counts_sales_group.size < 8))
      @size = ((@counts_sales_group.size * 60).to_s+ "x" + (@counts_sales_group.max * 1).to_s).to_s
    else
      @size = "800x150"
    end      
  end    
  
  def start_date
    begin
      @start_date = DateTime.civil(params[:st][:"start_date(1i)"].to_i,     
                                  params[:st][:"start_date(2i)"].to_i,
                                  params[:st][:"start_date(3i)"].to_i, 
                                  params[:st][:"start_date(4i)"].to_i,
                                  params[:st][:"start_date(5i)"].to_i)
    rescue      
      @start_date = DateTime.civil(params[:st][:"start_date(1i)"].to_i, 
                                params[:st][:"start_date(2i)"].to_i+1, 
                                1,
                                params[:st][:"start_date(4i)"].to_i,
                                params[:st][:"start_date(5i)"].to_i)
    end    
  end
  
  def end_date
    begin
      @end_date = DateTime.civil(params[:et][:"end_date(1i)"].to_i, 
                                params[:et][:"end_date(2i)"].to_i, 
                                params[:et][:"end_date(3i)"].to_i, 
                                params[:et][:"end_date(4i)"].to_i, 
                                params[:et][:"end_date(5i)"].to_i)
    rescue                                
      @end_date = DateTime.civil(params[:et][:"end_date(1i)"].to_i, 
                                params[:et][:"end_date(2i)"].to_i+1, 
                                "1".to_i, 
                                params[:et][:"end_date(4i)"].to_i, 
                                params[:et][:"end_date(5i)"].to_i)
    end                          
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
