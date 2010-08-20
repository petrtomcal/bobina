class Admin::UsersController < ApplicationController
  before_filter :check_authentication , :except => ['login','registration','create_registration']
  
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

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
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
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
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
  
  def info
    session[:user_id] = 1# pouze aby proslo do layoutu aplication
    redirect_to :action => 'index'
  end
  
  def login
    #user = User.find_by_credentials(params[:email], params[:password_hash])
    #user = User.find(:first)
    session[:user_id] = 1#user.id
    redirect_to :action => 'index'
  end
  
  def logout
    reset_session
    flash[:notice] =  'User logout.'
    render :template => 'admin/users/login', :layout => 'access'
    return false
  end
  
  def registration
    unless @user
      @user = User.new
    end
=begin
    chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
    @random_text = RAILS_ENV == 'test' ? 'TEST':((1..6).collect{|a| chars[rand(chars.size)] }.join).upcase
=end
    render :action => 'registration', :layout => 'registration'
  end
  
  def create_registration
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully registred.'
        render :template => 'admin/users/login', :layout => 'access'
        return false
        #format.html { redirect_to :action => 'info' }
        #format.xml  { render :xml => @user, :status => :created, :location => @user }
      end
    end
  end
end
