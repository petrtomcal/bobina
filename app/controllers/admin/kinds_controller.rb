class Admin::KindsController < ApplicationController
  
  def index
    @kinds = Kind.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @kinds }
    end
  end

end
