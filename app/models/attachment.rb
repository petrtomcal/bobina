class Attachment < ActiveRecord::Base
  
  belongs_to :product
    
  has_attached_file :file,
                    :path => ":rails_root/public/product/:id/:basename.:extension"
                    
  def delete_dir(id)
    attachment_dir = File.join(RAILS_ROOT, 'public', 'product',id )
    
    #File.delete(attachment_dir, '*') 
    #if File.exist?("#{RAILS_ROOT}/dirname/#{@filename}")
      
    if File.exist?(attachment_dir)
        Dir.delete(attachment_dir)
    end      
  end  
  
end
