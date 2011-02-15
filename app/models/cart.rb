class Cart < ActiveRecord::Base
  #tableless :columns => [
  #              [:product_id, :integer]]
  class_inheritable_accessor :columns
  self.columns = []
 
  #def self.comlumns()
  #  @columns ||= [];
  #end
  
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end
 
  #column :product_id, :integer 
  
  def paypal_url(return_url, _items)
    
    values = {
      :business => 'seller_1292877565_biz@gmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => rand(36**8).to_s(36) #info cislo faktur
    }        
    #debugger
    _items.each_with_index do |item,index|
        values.merge!({
          "amount_#{index+1}" => item[0].price,
          "item_name_#{index+1}" => item[0].name,
          "item_number_#{index+1}" => item[0].id,
          "quantity_#{index+1}" => item[1]          
        })
    end
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end  
end 