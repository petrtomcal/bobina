class CartDrop < Liquid::Drop
  
  def initialize(_items)
    @product_items ||= []
    @pack_items ||= []    
    _items["products"].each_pair{ |key,value| @product_items << ProductDrop.new(Product.find(key),value) }    
    _items["collection"].each_pair{ |key,value| @pack_items << PackDrop.new(Pack.find(key),value) }
  end  
  
  def get_product_items    
    @product_items
  end
    
  def get_pack_items
    @pack_items
  end
  
  def total_count
    @product_items.map{|p| p.count.to_i}.sum + @pack_items.map{|p| p.count.to_i}.sum
  end
  
  def total_price
    @product_items.map{|p| p.price * p.count}.sum + @pack_items.map{|p| p.price * p.count}.sum
  end  
  
  def checkout_link
    "checkout link by drop"
  end
end