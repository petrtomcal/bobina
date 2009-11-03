class AdminEshopAbstract < ActiveRecord::Base
  self.abstract_class = true
  establish_connection 'admin_eshop'
end