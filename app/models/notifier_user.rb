class NotifierUser < ActionMailer::Base
  
  def registration_confirmation(user_id)
    user = User.find(user_id)
    @subject = "Confirmate your registration"
    @recipients = user.email
    @from = "NOTIFIER_EMAIL"
    @sent_on = Time.now
    @content_type = "text/html" 
    @body = { 'user' => user }
  end
  
  def checkout(user)
    user = User.find(user_id)
    @subject = "Confirmate your order"
    @recipients = user.email
    @from = "NOTIFIER_EMAIL"
    @sent_on = Time.now
    @content_type = "text/html" 
    @body = { 'user' => user } 
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
  
end
