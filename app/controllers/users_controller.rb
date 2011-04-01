class UsersController < ApplicationController
  before_filter :session_check
  layout "registration" 
  
  def edit
    @user = User.find(session[:user_id])
  end

  def update
    
    @user = User.find(session[:user_id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User sucesfully edited.'
        format.html { redirect_to :action => "edit" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def password    
    @user = User.find(session[:user_id])  
  end
  
  def update_password
    old_pass = params[:pass]
    pass = params[:user][:password]
    pass_conf = params[:user][:password_confirmation]
    @user = User.find(session[:user_id])
    if Digest::SHA256.hexdigest(old_pass["old_password"]) == @user.password_hash
      if pass == pass_conf
        @user.password_hash = Digest::SHA256.hexdigest(pass)
        @user.save
        flash[:notice] = 'Password was successfully changed.'
      else
        flash[:warning] = 'Passwords do not match.'
      end  
    else
      flash[:warning] = 'Bad password.'
    end
    render :action => 'password', :id => @user.id
  end
  
end
