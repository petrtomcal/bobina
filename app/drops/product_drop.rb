class ProductDrop < Liquid::Drop
  
  def initialize(name,category_id,price,attachments,id)
    @name = name
    @category_id = category_id
    @price = price
    @attachments = attachments
    @id = id
  end
  
  def name
    @name
  end
  
  def category_id
    @category_id
  end
  
  def price
    @price
  end
  
  def attachments
    @attachments
  end
  
  def id
    @id
  end
  
end