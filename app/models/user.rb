class User < ActiveRecord::Base
validates_presence_of :email, :message => 'can not be blank'
validates_uniqueness_of :email, :message => 'must be unique'

apply_simple_captcha 

end
