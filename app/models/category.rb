class Category < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :gallery
  
end
