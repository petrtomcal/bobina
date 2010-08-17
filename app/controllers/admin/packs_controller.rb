class Admin::PacksController < ApplicationController
  def index
      @packs = Pack.all
      respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @packs }
    end
  end
  
  # GET /users/1
  # GET /users/1.xml
  def show
    @pack = Pack.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pack }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @pack = Pack.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pack }
    end
  end

  # GET /users/1/edit
  def edit
    @pack = Pack.find(params[:id])    
  end

  # POST /users
  # POST /users.xml
  def create
    @pack = Pack.new(params[:pack])

    respond_to do |format|
      if @pack.save
        flash[:notice] = 'Package sucefully added.'
        format.html { redirect_to :action => 'index' }
        format.xml  { render :xml => @pack, :status => :created, :location => @pack }
      else
        format.html { render :action => 'new' }
        format.xml  { render :xml => @pack.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    
    @pack = Pack.find(params[:id])

    respond_to do |format|
      if @pack.update_attributes(params[:pack])
        flash[:notice] = 'Package sucesfully edited.'
        format.html { redirect_to :action => 'index' }
        format.xml  { head :ok }
      else
        format.html { render :action => 'edit' }
        format.xml  { render :xml => @pack.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @pack = Pack.find(params[:id])
    @pack.destroy

    respond_to do |format|
      format.html { redirect_to :action => 'index' }
      format.xml  { head :ok }
    end
  end
end
