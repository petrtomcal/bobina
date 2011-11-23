class Admin::ProductsController < ApplicationController
  before_filter :check_authentication
    
  def index
      @products = Product.all
      respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end
  
  def show
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  def edit
    @product = Product.find(params[:id])    
  end

  def create
    @product = Product.new(params[:product])
    
    respond_to do |format|
      if @product.save
        flash[:notice] = 'Product was successfully created. Please upload content for product.'
        session[:product_id] = @product.id
        format.html { redirect_to :action => 'new_attachment' }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update    
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Product was successfully edited.'
        format.html { redirect_to :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    
    if @product.packs.empty?
      @product.destroy
      flash[:notice] = 'Product was sucesfully deleted.'
      respond_to do |format|
        format.html { redirect_to :action => 'index' }
        format.xml  { head :ok }
      end
    else
      flash[:notice] = 'Product is in package. Remove from package first.'
      redirect_to :controller => 'packs', :action => 'show', :id => @product.packs.first.id
    end  
  end
  
  def show_categories
    @product = Product.find(params[:product_id])        
    @products_category = @product.categories.find(:all)
    @category_all = Category.all - @products_category    
  end
  
  def del_category_from_product
    Category.find(params[:category_id]).remove_product(params[:product_id])
    redirect_to :action => 'show_categories', :product_id => params[:product_id]
  end
  
  def add_category_to_product
    product = Product.find(params[:product_id])
    category = Category.find(params[:category_id])    
    @pc = ProductsCategory.new
    @pc.product = product
    @pc.category = category
    @pc.save
    redirect_to :action => 'show_categories', :product_id => params[:product_id]
  end
  
  def download    
    begin
      attachment = Attachment.find(params[:attachment_id])
      file_path = File.join(attachment.file.path)
      send_file(file_path, :filename => attachment.file_file_name , :stream => false)      
    rescue
      render :text => "File not found", :status => 404
    end
  end
  
  
  def new_attachment    
    if params[:product_id].nil?
      @product = Product.find(session[:product_id])
    else
      @product = Product.find(params[:product_id])
    end  
    @attachment = Attachment.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end
  
  def upload_attachment    
    @product = Product.find(params[:product_id])
    @attachment = @product.attachments.new(:file => params[:attachment])
    url = request.host      
    eshop = url.split(".").first
    @attachment.subdomain = eshop
    
    if @attachment.save
      status = '<div id="output">success</div>'
      render :text => "#{status} <div id='message'>Attachment was sucesfully added.</div>", :layout => "upload"
    else
      status = '<div id="output">failed</div>'
      render :text => "#{status} <div id='message'>Sorry something was wrong.</div>", :layout => "upload"
    end
  end  
  
  def generate_link
    @product = Product.find(params[:id])    
    @id = @product.id
    @url_host = request.host      
    @product.weblink = "<a href='#{@url_host}/carts/create_order?type=product&id=#{@id}'>Your description</a>"
    @product.save        
    redirect_to :action => 'show', :id => @product.id
  end
end
