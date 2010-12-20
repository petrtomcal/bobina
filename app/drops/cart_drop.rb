class CartDrop < Liquid::Drop
  
  def initialize(_items)
    @items = []
    _items.each_pair{ |key,value| @items << ProductDrop.new(Product.find(key),value) }
    # _items.each_pair{ |key,value| @items << ProductDrop.new(Product.find(key),value) }
  end  
  
  def get_items
    @items
  end
    
  def total_count
    @items.map{|p| p.count.to_i}.sum
  end
  
  def total_price
    @items.map{|p| p.price * p.count}.sum
  end  
end