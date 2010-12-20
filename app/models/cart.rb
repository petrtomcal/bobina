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
  
end 