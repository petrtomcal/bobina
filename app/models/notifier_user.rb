class NotifierUser < ActionMailer::Base
  
  def new_shop_confirmation(amdmineshop_id, pass)
    ae = AdminEshop.find(amdmineshop_id)
    @subject = "Confirmate your registration"
    @recipients = ae.email
    @from = "NOTIFIER_EMAIL after db create and migratation task"
    @sent_on = Time.now
    @content_type = "text/html" 
    @body = { 'user' => ae }
  end
  
  def registration_confirmation(user_id)
    user = User.find(user_id)
    @subject = "Confirmate your registration"
    @recipients = user.email
    @from = "NOTIFIER_EMAIL"
    @sent_on = Time.now
    @content_type = "text/html" 
    @body = { 'user' => user }
  end
  
  def checkout(user_id, sale_token, domain)
    user = User.find(user_id)
    @subject = "Confirmate your order"
    @recipients = user.email
    @from = "NOTIFIER_EMAIL"
    @sent_on = Time.now
    @content_type = "text/html" 
    @body = { 'user' => user, 'sale_token' => sale_token, 'domain' => domain  } 
  end
  
  def password_change(user_id)
    user = User.find(user_id)
    @subject = "Password change"
    @recipients = user.email
    @from = "NOTIFIER_EMAIL"
    @sent_on = Time.now
    @content_type = "text/html" 
    @body = { 'user' => user } 
  end 
  
  def download_link(user_id)
    user = User.find(user_id)
    @subject = "Link for downloading"
    @recipients = user.email
    @from = "NOTIFIER_EMAIL"
    @sent_on = Time.now
    @content_type = "text/html" 
    @body = { 'user' => user }
  end
  
  def create(user_id, pass)
    user = User.find(user_id)
    @subject = "Registration"
    @recipients = user.email
    @from = "NOTIFIER_EMAIL"
    @sent_on = Time.now
    @content_type = "text/html" 
    @body = { 'user' => user, 'pass' => pass }
  end
  
  
  def new_shop_confirmation(admineshop_id, pass)
    admineshop = AdminEshop.find(admineshop_id)
    @subject = "Registration new shop"
    @recipients = admineshop.email
    @from = "NOTIFIER_EMAIL"
    @sent_on = Time.now
    @content_type = "text/html" 
    @body = { 'admineshop' => admineshop, 'pass' => pass }
  end
  
end
