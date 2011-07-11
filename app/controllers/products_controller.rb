class ProductsController < ApplicationController
  before_filter :session_check, :except => [:index, :empty_cart, :show, :get_downloads_links, :download_by_token]
  
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
    products = (Product.all :joins => :attachments).uniq.collect { |p| ProductDrop.new(p) }
    packs = Pack.all.collect { |p| PackDrop.new(p) }
    cart = CartDrop.new(session[:items], nil)    
    assigns = {'products' => products, 'cart' => cart, 'packs' => packs}
    assigns = assigns.merge(get_user_hash) if session[:user_id]
    render_liquid_template 'products/list', assigns, self    
  end
  
  def show
    p = Product.find_by_id(params[:id])
    product = ProductDrop.new(p, nil)
    attachments = AttachmentDrop.new(p.attachments)
    attachments = product.attachments.collect { |a| AttachmentDrop.new(a) }
    assigns = {'product' => product, 'attachments' => attachments}
    assigns = assigns.merge(get_user_hash) if session[:user_id]
    render_liquid_template 'products/show', assigns, self
  end
  
  def empty_cart
    session[:items]["products"] = Hash.new
    session[:items]["collection"] = Hash.new
    index    
  end
  
  #info - rfc
  def sale_history_list_download    
    sales = Sale.find(:all, :conditions => { :user_id => session[:user_id] })    
    @sales = sales.collect { |s| SaleDrop.new(s) }    
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
    assigns = {'products' => @products, 'packs' => @packs, 'sales' => @sales}
    assigns = assigns.merge(get_user_hash) if session[:user_id]
    render_liquid_template 'products/sale_history_list_download', assigns, self       
  end
  
  def sale_history_list    
    sales = Sale.find(:all, :conditions => { :user_id => session[:user_id] })    
    @sales = sales.collect { |s| SaleDrop.new(s) }    
    assigns = {'sales' => @sales}
    assigns = assigns.merge(get_user_hash) if session[:user_id]
    render_liquid_template 'products/sale_history_list', assigns, self         
  end
  
  
  #logged
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
    if !@sales.nil?
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
      #product_id = Product.find(params[:id], :select => 'id').id  #params id is  attachment
      attachment = Attachment.find(params[:id])      
      if products_id.include?(attachment.product_id)
        begin          
          #attachment = Attachment.find_by_product_id(product_id)
          file_path = File.join(attachment.file.path)          
          send_file(file_path, :filename => attachment.file_file_name , :stream => true)      
        rescue
          render :text => "File not found", :status => 404
        end      
      else  
        redirect_to :action => 'sale_history_list'  
      end    
    else
      redirect_to :action => 'index'
    end
  end
  
  def get_downloads_links
    
    #@sale = Sale.all( :conditions => { :created_at => start_date..end_date }, :joins => [:sales_products], :select => "sales.*, sum(  sales_products.count) as products_count", :group => "sales.id").group_by{ |sale| sale.created_at.strftime("(%y/%d/%m)") }
    
    sale = Sale.first(:conditions => { :token => params[:text] })
    if sale.nil?
      redirect_to :action => 'index'          
    else
      @products = sale.products
    
      unless sale.packs.empty?
        sale.packs.each {|pack|
          @products = pack.products + @products        
        } 
      end
      @attachments ||= []
      @products.each {|p|
        @attachments = p.attachments.all.collect { |attachment| AttachmentDrop.new(attachment) } + @attachments        
      }
      assigns = {'attachments' => @attachments, 'token' => params[:text]}      
      #error #info - didn't get content
      render_liquid_template 'products/download_by_token', assigns, self    
    end
  end
  
  def download_by_token
    
    sale = Sale.first(:conditions => { :token => params[:token] })
    #token = "text=" + params[:token]
      @products ||= []
      packs ||= []
      
        @products = sale.products
        
        packs = sale.packs 
        packs.each {|p|
          @products = @products + p.products
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
      redirect_to :action => 'get_downloads_links', :text => params[:token]
    end        
  end
  #info private
  def get_user_hash
    @user = User.find(session[:user_id])
    user = UserDrop.new(@user)
    userhash = {'user' => user}
  end
  
end
