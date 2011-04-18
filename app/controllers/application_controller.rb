# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include DatabaseHelper #info db helper
  
  include EshopModule::Liquid::LiquidTemplate  #info comment for cucumber  
  #includnuti metod z liquid_template
  
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :set_db, :set_skin, :reset_session_expiry
  
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
  
  def check_authentication#info last flash only    
    unless session[:user_id] 
      flash[:notice] = 'Login yourself please.'      
      redirect_to :controller => 'users', :action => 'login'      
      return false
    end
    unless User.find(session[:user_id]).admin == 1
      flash[:notice] = 'Sorry you, but you should be administrator.'      
      debugger
      redirect_to :controller => 'users', :action => 'login'      
      return false
    end
  end
  
  def session_check
    unless session[:user_id]
      redirect_to :controller=> '../products', :action => 'index'
    end
  end

  protected
  
  def reset_session_expiry
  	creation_time = session[:creation_time] || Time.now
    if !session[:expiry_time].nil? and session[:expiry_time] < Time.now
      reset_session
      $logout = 'logout'
    else
      $logout = ''
      session[:expiry_time] = 15.minutes.from_now
    end    
    return true
  end
    
end
