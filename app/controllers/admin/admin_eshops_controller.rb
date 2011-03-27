class Admin::AdminEshopsController < ApplicationController
  def new_shop  
    @admineshop = AdminEshop.new
    respond_to do |format|
      format.html { render :action => 'new_shop', :layout => 'registration' }
      format.xml  { render :xml => @user }
    end    
  end
  
  def create_shop
    @admineshop = AdminEshop.new(params[:admineshop])
    pass = rand(36**8).to_s(36)
    @admineshop.password_hash = Digest::SHA256.hexdigest(pass)   
    respond_to do |format|
      if @admineshop.save
        flash[:notice] = 'Your subdomain was registered. Wait for email please.'
        NotifierUser.deliver_new_shop_confirmation(@admineshop.id, pass)
        #info db create...migration task
        #rake db:create
        format.html { redirect_to :controller => 'users', :action => 'index' }
      else         
       format.html { render :action => 'new_shop', :layout => 'registration' }
      end
    end
  end   
end
