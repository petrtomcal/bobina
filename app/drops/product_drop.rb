class ProductDrop < Liquid::Drop
  
  def initialize(_product, _count=nil )    
    @product = _product
    unless _count == nil
      @product.count = _count        
    end
  end
  
  def name
    @product.name
  end
  
  def category_id
    @product.category_id
  end
  
  def price
    @product.price
  end
  
  def attachments
    @product.attachments
  end
  
  def id
    @product.id
  end
  
  def count
    @product.count
  end
  
end