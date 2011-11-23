class Admin::AttachmentsController < ApplicationController
  def destroy
    @attachment = Attachment.find(params[:attachment_id])
    @attachment.destroy
    flash[:notice] = 'Attachment was successfully destroyed.'
    respond_to do |format|
      format.html { redirect_to :controller => 'products', :action => 'show', 'id' => params[:id] }
      format.xml  { head :ok }
    end
  end
  

end
