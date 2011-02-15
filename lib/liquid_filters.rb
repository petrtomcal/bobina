module LiquidFilters
  include ActionView::Helpers::NumberHelper

  def currency(price)
    number_to_currency(price)    
  end
  
  def number_to_czk(price)
    number_to_currency(price, :unit => "Kč", :separator => ",", :delimiter => " ", :format => "%n %u")
  end
  
  def number_to_usd(price)
    number_to_currency(price, :unit => "USD", :separator => ",", :delimiter => " ", :format => "%n %u")
  end
end
