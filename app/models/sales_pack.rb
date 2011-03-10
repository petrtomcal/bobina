class SalesPack < ActiveRecord::Base
  
  belongs_to :sale
  belongs_to :pack
  
end
