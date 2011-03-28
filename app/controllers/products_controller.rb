class ProductsController < ApplicationController
  before_filter :session_check, :except => [:index, :empty_cart, :show, :get_downloads_links]
  
  def index
    session[:items] ||= Hash.new
    @cart = Cart.new    
    list    
  end
  
  def list
    session[:items] ||= Hash.new
    @cart = Cart.new
    session[:items]["products"] ||= Hash.new
    session[:items]["collection"] ||= Hash.new
    products = Product.all.collect { |p| ProductDrop.new(p) }
    packs = Pack.all.collect { |p| PackDrop.new(p) }
    cart = CartDrop.new(session[:items])    
    assigns = {'products' => products, 'cart' => cart, 'packs' => packs}
    assigns = assigns.merge(get_user_hash) if session[:user_id]
    render_liquid_template 'products/list', assigns, self    
  end
  
  def show
    p = Product.find_by_id(params[:id])
    product = ProductDrop.new(p, nil)
    assigns = {'product' => product}
    assigns = assigns.merge(get_user_hash) if session[:user_id]
    render_liquid_template 'products/show', assigns, self
  end
  
  def empty_cart
    session[:items]["products"] = Hash.new
    session[:items]["collection"] = Hash.new
    index    
  end
  
  #info - rfc
  def sale_history_list    
    sales = Sale.find(:all, :conditions => { :user_id => session[:user_id] })    
    times = sales.size    
    sales.each {|s|    
    if times == sales.size
      @products = s.products.collect { |p| ProductDrop.new(p) }
      @packs = s.packs.collect { |p| PackDrop.new(p) }
    else       
      @products = @products + s.products.collect { |p| ProductDrop.new(p) }
      @packs = @packs + s.packs.collect { |p| PackDrop.new(p) }     
    end
    times =- 1
    }    
    assigns = {'products' => @products, 'packs' => @packs}
    assigns = assigns.merge(get_user_hash) if session[:user_id]
    render_liquid_template 'products/sale_history_list', assigns, self       
  end
  
  def download_links    
    product = Product.find(params[:id])
    attachments = product.attachments.all.collect { |attachment| AttachmentDrop.new(attachment) }  
    assigns = {'attachments' => attachments}
    assigns = assigns.merge(get_user_hash) if session[:user_id]
    render_liquid_template 'products/download_links', assigns, self
  end
  
  #info - rfc
  def download#info maybe zip for one link    
      @sales = Sale.find(:all, :conditions => { :user_id => session[:user_id] })
      @products ||= []
      @packs ||= []
      @sales.each {|s|
        @products = s.products.collect + @products
        
        @packs = @packs + s.packs.collect        
        @packs.each {|p|
          @products = @products + p.products.collect 
        }
      }
    
    products_id = @products.collect{|p| p.id}
    p_id = Attachment.find(params[:id], :select => 'product_id')    
    if products_id.include?(p_id.product_id)
      begin        
        attachment = Attachment.find(params[:id])
        file_path = File.join(attachment.file.path)
        send_file(file_path, :filename => attachment.file_file_name , :stream => false)      
      rescue
        render :text => "File not found", :status => 404
      end      
    else  
      redirect_to :action => 'sale_history_list'  
    end    
  end
  
  def get_downloads_links    
    sale = Sale.first(:conditions => { :token => params[:text] })
        
    @products = sale.products.collect { |p| ProductDrop.new(p) }
    packs = sale.packs
    packs.each {|pack|
      @products = pack.products.collect { |p| ProductDrop.new(p) } + @products
    }
    
    assigns = {'products' => @products}
    render_liquid_template 'products/token', assigns, self
  end
  
  #info private
  def get_user_hash
    @user = User.find(session[:user_id])
    user = UserDrop.new(@user)
    userhash = {'user' => user}
  end
  
end
