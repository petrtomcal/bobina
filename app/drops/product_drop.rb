class ProductDrop < Liquid::Drop
  
  def initialize(name,category_id)
    @name = name
    @category_id = category_id
  end
  
  def name
    @name
  end
  
  def category_id
    @category_id
  end
  
end