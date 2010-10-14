class Admin::AttachmentsController < ApplicationController
  #def destroy
  #  @attachment = Attachment.find(params[:attachment_id])
  #  @attachment.destroy

  #  respond_to do |format|
  #    format.html { redirect_to :controller => 'products', :action => 'index' }
  #    format.xml  { head :ok }
  #  end
  #end
  
  #def destroy_all_from_product
  #  @attachments = Attachment.find_all_by_product_id(params[:id])
  #  #debugger
  #  product_id = @attachments.first.product_id

  #  @attachments.each do |attachment| 
  #  #debugger 
  #    attachment.destroy
  #  end

  #  respond_to do |format|
  #    format.html { redirect_to :controller => 'products', :action => 'destroy', :product_id => product_id }
  #    format.xml  { head :ok }
  #  end
  #end

end
