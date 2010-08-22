# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include DatabaseHelper #musi se includovat jinak nefunguje
  include EshopModule::Liquid::LiquidTemplate #includnuti metod z liquid_template
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :set_db, :set_skin
  
  def default_order_properties
    'id'
  end
 
  def default_filter
    {}
  end
  
  def set_skin
    subdomain = request.host.split(".").first      
    FileUtils.mkdir_p File.join( RAILS_ROOT, 'liquid', subdomain )
    @skin_templates = File.join( RAILS_ROOT, 'liquid', subdomain )
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
