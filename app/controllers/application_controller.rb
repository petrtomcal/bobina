# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include DatabaseHelper #musi se includovat jinak nefunguje
  include PofFunctions #obsahuje funkce pro razeni
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :set_db
  
  def default_order_properties
    'id'
  end
 
  def default_filter
    {}
  end
  
  def check_authentication
    #if session[:user_id] == 0
    #  flash[:notice] = 'Přihlašte se prosím'
    #  render :template => 'admin/users/login', :layout => 'access'
    #  return false
    #end
    unless session[:user_id]
      flash[:notice] = 'Login yourself please.'
      render :template => 'admin/users/login', :layout => 'access'
      return false
    end
 end
end
