class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]  
  skip_before_filter :verify_authenticity_token, :except => [:create]

  
  def create
    sale_id = Sale.find_by_token(params[:invoice]).id        
    PaymentNotification.create!(:params => params, :sale_id => sale_id, :status => params[:payment_status], :transaction_id => params[:txn_id])
    sale = Sale.find_by_token(params[:invoice])
    user = User.find(sale.user_id)    
    NotifierUser.deliver_checkout(user.id, sale.token, request.host.split(".").first)
    render :nothing => true
  end

end


