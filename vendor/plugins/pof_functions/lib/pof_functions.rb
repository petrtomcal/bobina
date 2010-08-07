module PofFunctions
  def self.append_features(base) #:nodoc:
    super
    base.class_eval do
      super
      
      def change_pof
        pof = self.pof(params)
        if params[:order] 
          pof.change_order_properties(params[:order])
          pof.first_page!
        elsif params[:page_no]
          pof.page_no = params[:page_no].to_i
        elsif params[:clear_filter]
          pof.filter = {} 
        elsif params[:items_per_page]
            pof.items_per_page = params[:items_per_page].to_i if params[:items_per_page].to_i > 0
#            pof.last_page_no = if params[:items_per_page] > pof.items_per_page 
        elsif params[:filter]
          pof.filter = {}
          for p in params[:filter]
            name, value = p
            if value.length > 0
              pof.filter[name] = value
            end
          end
        end
        redirect_to(pof.redir_url)
      end
      
      protected
      def pof(options = {})
        options[:tbl_name] = self.controller_name.tableize if options[:tbl_name].nil?
        options[:pof_name] = self.controller_name if options[:pof_name].nil?
        options[:redir_url] = {:action => 'list'} if options[:redir_url].nil?
        session_key = "#{options[:pof_name]}/pof"
        pof = session[session_key]
        if pof.nil?
          pof = Pof.new(options)
          pof.order_properties = default_order_properties
          pof.filter = default_filter
          session[session_key] = pof
        end
        return pof    
      end  
      
    end
  end
end