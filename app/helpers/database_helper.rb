module DatabaseHelper
  #porovnani vyparsovane hodnoty z url s hodnotu z db  
  def set_db
    begin
      if ENV["RAILS_ENV"] == "test"
        url = "test"
      else
        url = request.host
      end
      @eshop = AdminEshop.find_by_domain(url.split(".").first)
                   
      ActiveRecord::Base.configurations[RAILS_ENV]['url'] = url
      raise "Requested database '#{url}' was NOT found" if @eshop.nil?
      db_name = @eshop.domain << "_eshop"
      
    rescue Exception => e
      db_name = nil
      headers["Status"] = "301 Moved Permanently"
      render(:text => e.to_s) and return false
    ensure
      unless db_name.blank?
        conn_string = ActiveRecord::Base.configurations[RAILS_ENV].merge({'database' => db_name }) 
      else
        conn_string = ActiveRecord::Base.configurations[RAILS_ENV]
      end
      ActiveRecord::Base.establish_connection(conn_string)
    end
    
  end

end