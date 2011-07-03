class Admin::SettingsController < ApplicationController
  before_filter :check_authentication 
  
  def edit
    @user = User.find(params[:id])
    @setting = Setting.find_by_user_id(@user.id)
    if @setting.nil?
      @setting = Setting.new("email" => "example@example.ex", "secret" => "your_secret", "cert_id" => 'your_cert_id', "url" => "URL", "user_id" => @user.id )
      @setting.save
      @setting      
    end  
  end  
  
  def update    
    @setting = Setting.find_by_user_id(params[:user_id])
    
    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        flash[:notice] = 'Setting was successfully saved.'
        format.html { redirect_to :action => 'show', :user_id => @setting.user_id }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    @setting = Setting.find_by_user_id(params[:user_id])
  end
  
end
