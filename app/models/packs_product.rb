class PacksProduct < ActiveRecord::Base
  
  belongs_to :product
  belongs_to :pack
  
  def self.find_association(pack_id, product_id)
    return self.find(:first, :conditions => ["pack_id = ? AND product_id = ?", pack_id, product_id])
  end
  
end
