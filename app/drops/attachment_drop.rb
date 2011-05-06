class AttachmentDrop < Liquid::Drop
  
  def initialize(_attachment)    
    @attachment = _attachment    
  end
  
  def id
    @attachment.id
  end
  
  def name
    @attachment.file_file_name
  end
  
  def product_id
    @attachment.product_id
  end
  
  def size
    @attachment.file_file_size
  end
  
end