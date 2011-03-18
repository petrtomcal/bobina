class User < ActiveRecord::Base
validates_presence_of :email, :message => "can't be blank."
validates_uniqueness_of :email, :message => 'must be unique. This is already registered.'
validates_format_of :email,
                    :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                    :message => 'Invalid  Email.'
attr_accessor :pasword_confirmation, :password
validates_confirmation_of :password
validates_presence_of :password, :on => :create, :message => "can't be blank."


apply_simple_captcha

  def self.find_by_credentials(email, pass)
     pswd_hash = Digest::SHA256.hexdigest(pass)         
     user = User.find_by_email_and_password_hash(email, pswd_hash)
     return user 
     rescue
     return nil
  end
  
end
