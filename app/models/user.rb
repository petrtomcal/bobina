class User < ActiveRecord::Base
validates_presence_of :email, :message => "can't be blank"
validates_uniqueness_of :email, :message => 'must be unique'

attr_accessor :pasword_confirmation, :password
validates_confirmation_of :password
validates_presence_of :password, :on => :create, :message => "can't be blank"


apply_simple_captcha

  
end
