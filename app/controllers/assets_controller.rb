class AssetsController < ActionController::Base
  
  include DatabaseHelper
  
  session :off
  caches_page :index 
    
  #helper :assets

  before_filter :set_db
  before_filter :change_skin_cache_dir
  
  def change_skin_cache_dir
    ::ActionController::Base.page_cache_directory = File.join(RAILS_ROOT,'public','system','cache',::ActiveRecord::Base.configurations[RAILS_ENV]['domain_name'])
  end
  
  def index
    path = File.join(@skin_templates,params[:dir],"#{params[:path]}.#{params[:ext]}")
    if File.exists?(path)
      render_path path
    else
      raise ::ActionController::RoutingError,
        "Assets Controller: Recognition failed for #{request.path.inspect}"
    end
  end

  private
  
  def render_path(path)
    
    extname = path.split('.').last
    key = path.gsub('/', '-')
    
    if image?(extname)
      content = File.open(path, "rb") { |f| f.read } 
      send_data content, 
        :filename => File.basename(path).to_s, 
        :type => content_type(extname), :disposition => 'inline' and return
    end
   
    headers['Content-Type'] = content_type(extname)
    headers['Cache-Control'] = 'max-age=315360000'
    headers['Cache-Control'] = 'private'
    headers['Expires'] = Time.now + 1.week
    
    content = render_to_string :file => path, :layout => false
  
    render :text => content, :layout => false
  end
  
  def content_type(extname)
    case extname
      when 'js'           then return 'text/javascript'
      when 'css'          then return 'text/css'
      when 'png'          then return 'image/png'
      when 'jpg', 'jpeg'  then return 'image/jpeg'
      when 'gif'          then return 'image/gif'
      when 'swf'          then return 'application/x-shockwave-flash'
      when 'ico'          then return 'image/x-icon'
    end
  end 

  def image?(extname)
    case extname
      when 'png'          then return true
      when 'jpg', 'jpeg'  then return true
      when 'gif'          then return true
      when 'swf'          then return true
      when 'ico'          then return true
    end
    return false
  end 
  
end
