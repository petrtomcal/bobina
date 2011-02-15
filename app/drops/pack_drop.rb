class PackDrop < Liquid::Drop
  
  def initialize(_pack, _count=nil)    
    @pack = _pack
    @pack.count = _count        
  end
  
  def name
    @pack.name
  end
  
  def category_id
    @pack.category_id
  end
  
  def price
    @pack.price
  end
  
  def total_price
    @pack.total_price
  end
  
  def attachments
    @pack.attachments
  end
  
  def id
    @pack.id
  end
  
  def count
    @pack.count
  end
  
end