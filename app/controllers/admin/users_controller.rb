class Admin::UsersController < ApplicationController
  before_filter :check_authentication , :except => ['login','registration','create_registration','logout']
  
  # GET /users
  # GET /users.xml
  def index
    #@pof = pof(:tbl_name => 'users')
	  #@pof.item_count = User.count(@pof.conds)
	  @users = User.all #(:conditions => @pof.conds, :order => @pof.order, :offset => @pof.offset, :limit => @pof.limit)
    #@users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User sucesfully added.'
        format.html { redirect_to :action => 'index' }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => 'new' }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def registration
    unless @user
      @user = User.new
    end
    respond_to do |format|
      format.html { render :action => 'registration', :layout => 'registration' }
      format.xml  { render :xml => @user }
    end
  end
  
  def create_registration
    @user = User.new(params[:user])
    @user.password_hash = Digest::SHA256.hexdigest(@user.password)
    respond_to do |format|
      if @user.save_with_captcha #@user.save and simple_captcha_valid?
        flash[:notice] = 'User successfully registered.'
        NotifierUser.deliver_registration_confirmation(@user.id)
        format.html { render :template => 'admin/users/login', :layout => 'access' }
      else        
        format.html { render :action => 'registration', :layout => 'registration' }        
      end
    end
  end
  
  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User sucesfully edited.'
        format.html { redirect_to :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to :action => 'index' }
      format.xml  { head :ok }
    end
  end
    
  def login
    user = User.find_by_credentials(params[:email], params[:password_hash])
    if user.nil?
      flash[:notice] =  'Wrong email or password.'
      render :action => 'login', :layout => 'access'
    else
      if user.admin == 1 
        session[:user_id] = user.id
        redirect_to :action => 'index'
      else
        session[:user_id] = user.id
        redirect_to :controller => '../products', :action => 'index'           
      end            
    end    
  end
  
  def logout
    reset_session
    flash[:notice] =  'User logout.'
    render :template => 'admin/users/login', :layout => 'access'
    return false
  end
    
  
  def new_attachment
    @product = Product.find(params[:product_id])
    @attachment = Attachment.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end
    
end
