class Admin::UsersController < ApplicationController
  before_filter :check_authentication , :except => ['login','registration','create_registration','logout','new_shop','create_shop']
  
  def index    
	  @users = User.all     
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def create
    pass = "password"+rand(100**2).to_s
    params[:user][:password_confirmation] = pass
    params[:user][:password] = pass
    @user = User.new(params[:user])    
    @user.password_hash = Digest::SHA256.hexdigest(pass)    
    respond_to do |format|
      if @user.save
        flash[:notice] = 'User sucesfully added.'
        NotifierUser.deliver_create(@user.id, pass)
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
  
  def edit
    @user = User.find(params[:id])
  end

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
      flash[:notice] =  'Wrong email or password.' if flash[:notice].nil?
      render :action => 'login', :layout => 'access'
    else
      if user.admin == 1 
        session[:user_id] = user.id
        redirect_to :action => 'index'
      else
        session[:user_id] = user.id
        redirect_to :controller => '../products', :action => 'list'           
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
  
  def password    
    @user = User.find(params[:id])  
  end
  
  def update_password
    old_pass = params[:pass]
    pass = params[:user][:password]
    pass_conf = params[:user][:password_confirmation]
    @user = User.find(params[:id])
    if Digest::SHA256.hexdigest(old_pass["old_password"]) == @user.password_hash
      if pass == pass_conf
        @user.password_hash = Digest::SHA256.hexdigest(pass)
        @user.save
        flash[:notice] = 'Password was successfully changed.'
      else
        flash[:warning] = 'Passwords  do not match.'
      end  
    else
      flash[:warning] = 'Bad password.'
    end
    render :action => 'password', :id => @user.id
  end
    
end
