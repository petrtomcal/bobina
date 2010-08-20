class Attachment < ActiveRecord::Base
  
  belongs_to :product
    
  has_attached_file :file,
                    :path => ":rails_root/public/product/:id/:basename.:extension"
  
end
