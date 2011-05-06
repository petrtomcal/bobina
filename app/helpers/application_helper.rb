# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def number_to_czk(price)
    number_to_currency(price, :unit => "Kč", :separator => ",", :delimiter => " ", :format => "%n %u")
  end 
  
  def number_to_usd(price)
    number_to_currency(price, :unit => "USD", :separator => ",", :delimiter => " ", :format => "%n %u")
  end 
  
  def size_to_bytes(size)    
    number_to_human_size(size, :precision => 2, :separator => ',')        
  end 
end
