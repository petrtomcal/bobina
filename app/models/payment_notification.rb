class PaymentNotification < ActiveRecord::Base
  
  belongs_to :sale
  serialize :params
  after_create :mark_sale_as_purchased
  
  private
  
  def mark_sale_as_purchased
    if status == "Completed"      
      sale.update_attributes(:purchased_at => Time.now, :paid => 1)
    end
  end
  
end