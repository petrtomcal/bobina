# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def number_to_czk(price)
    number_to_currency(price, :unit => "Kč ", :separator => ",", :delimiter => " ", :format => "%n %u")
  end 
end
