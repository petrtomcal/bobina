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
    @product.destroy

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
end
