class UserDrop < Liquid::Drop
  
  def initialize(_user)    
    @user = _user    
  end
  
  def name
    @user.name
  end
  
  def id
    @user.id
  end  
  
  def email
    @user.email
  end
  
end