class AdminEshop <AdminEshopAbstract
  set_table_name 'eshops'
  
  validates_presence_of :domain, :message => "can't be blank."
  validates_uniqueness_of :domain, :message => 'must be unique. This is already registered.'
  validates_format_of :domain,
                    :with => /^[a-zA-Z0-9\-]*?$/,
                    :message => 'has invalid name. Use a-z and 0-9 characters'
                    
  validates_presence_of :email, :message => "can't be blank."
  validates_format_of :email,
                    :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                    :message => 'is invalid.'
end