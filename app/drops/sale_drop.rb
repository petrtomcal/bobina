class SaleDrop < Liquid::Drop
  
  def initialize(_sale)    
    @sale = _sale    
  end
  
  def id
    @sale.id
  end
  
  def user_id
    @sale.user_id
  end
  
  def paid
    @sale.paid
  end
  
  def created_at
    @sale.created_at
  end
  
  def updated_at
    @sale.updated_at
  end
  
  def token
    @sale.token
  end
  
  def purchased_at
    @sale.purchased_at
  end  
  
end