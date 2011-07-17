class Admin::PacksController < ApplicationController
  before_filter :check_authentication

  def index
    @packs = Pack.all
   
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @packs }
    end
  end
  
  def show
    @pack = Pack.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pack }
    end
  end

  def new
    @pack = Pack.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pack }
    end
  end

  def edit
    @pack = Pack.find(params[:id])    
  end

  def create
    @pack = Pack.new(params[:pack])

    respond_to do |format|
      if @pack.save
        flash[:notice] = 'Package was successfully created.'
        format.html { redirect_to :action => 'index' }
        format.xml  { render :xml => @pack, :status => :created, :location => @pack }
      else
        format.html { render :action => 'new' }
        format.xml  { render :xml => @pack.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    
    @pack = Pack.find(params[:id])

    respond_to do |format|
      if @pack.update_attributes(params[:pack])
        flash[:notice] = 'Package was successfully edited.'
        format.html { redirect_to :action => 'index' }
        format.xml  { head :ok }
      else
        format.html { render :action => 'edit' }
        format.xml  { render :xml => @pack.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @pack = Pack.find(params[:id])
    @pack.destroy
    flash[:notice] = 'Package was sucesfully destroyed.'
    
    respond_to do |format|
      format.html { redirect_to :action => 'index' }
      format.xml  { head :ok }
    end
  end
  
  def show_products
    @pack = Pack.find(params[:pack_id])    
    @packs_product = @pack.products.find(:all)
    @product_all = (Product.all :joins => :attachments).uniq - @packs_product
  end
  
  def del_product_from_pack
    Pack.find(params[:pack_id]).remove_product(params[:product_id])
    redirect_to :action => 'show_products', :pack_id => params[:pack_id]
  end
  
  def add_product_to_pack
    product = Product.find(params[:product_id])
    pack = Pack.find(params[:pack_id])    
    @pp = PacksProduct.new
    @pp.product = product
    @pp.pack = pack
    @pp.save
    redirect_to :action => 'show_products', :pack_id => params[:pack_id]
  end
  
  def generate_link
    @pack = Pack.find(params[:id])    
    @id = @pack.id
    @url_host = request.host      
    @pack.weblink = "<a href='#{@url_host}/carts/create_order?type=pack&id=#{@id}'>Your description</a>"
    @pack.save        
    redirect_to :action => 'show', :id => @pack.id
  end
  
end
