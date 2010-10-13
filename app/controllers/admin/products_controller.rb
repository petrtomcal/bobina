class Admin::ProductsController < ApplicationController
  def index
      @products = Product.all
      respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end
  
  # GET /users/1
  # GET /users/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /users/1/edit
  def edit
    @product = Product.find(params[:id])    
  end

  # POST /users
  # POST /users.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        flash[:notice] = 'Product sucesfully added.'
        format.html { redirect_to :action => 'index' }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Product sucesfully edited.'
        format.html { redirect_to :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @product = Product.find(params[:id])
    
    #info - vyresit pomoci paperclipu/nemaze soubory z adresare
    #@pa = @product.attachments
    debugger
    #Attachment.find_by_product_id(15).delete_dir('39')
    #Attachment.delete_dir(@product.id)
    #Attachment.find_all_by_product_id(@product.id).destroy #if nil     
    #@product.attachment.destroy
    #@product.delete

    respond_to do |format|
      format.html { redirect_to :action => 'index' }
      format.xml  { head :ok }
    end
  end
  
  def show_categories
    @product = Product.find(params[:product_id])    
    #@categories = Category.all
    #debugger
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
  
  #takto upravit vsechny metody v controlleru #info
  def new_attachment
    @product = Product.find(params[:product_id])
    @attachment = Attachment.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end
  
  def upload_attachment
    @product = Product.find(params[:product_id])
    @attachment = @product.attachments.new(:file => params[:attachment])
    if @attachment.save
      status = '<div id="output">success</div>'
      render :text => "#{status} <div id='message'>Attachment was sucesfully added.</div>"
    else
      status = '<div id="output">failed</div>'
      render :text => "#{status} <div id='message'>Sorry something was wrong.</div>"
    end
  end  
end
