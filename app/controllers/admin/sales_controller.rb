class Admin::SalesController < ApplicationController
  
  def index
    @sale = Sale.new
  end
  
  def products_by_user
    @start_date = DateTime.civil(params[:st][:"start_date(1i)"].to_i,     
                                  params[:st][:"start_date(2i)"].to_i,
                                  params[:st][:"start_date(3i)"].to_i, 
                                  params[:st][:"start_date(4i)"].to_i,
                                  params[:st][:"start_date(5i)"].to_i)
    @end_date = DateTime.civil(params[:et][:"end_date(1i)"].to_i, 
                                params[:et][:"end_date(2i)"].to_i, 
                                params[:et][:"end_date(3i)"].to_i, 
                                params[:et][:"end_date(4i)"].to_i, 
                                params[:et][:"end_date(5i)"].to_i)    
    @sale = Sale.find(:all, :conditions => { :created_at => @start_date..@end_date}, :order =>  "created_at").group_by{ |sale| sale.created_at.strftime("(%y/%d/%m)") }
    @counts_sales_group ||= []
    @sale.each {|key, value|  @counts_sales_group << value.size }
    @one_point = @counts_sales_group.max/@sale.keys.size
    @y_label ||= []
    @y_label << 0 << @one_point << @one_point+@one_point << @one_point+@one_point+@one_point << @counts_sales_group.max    
  end
end
