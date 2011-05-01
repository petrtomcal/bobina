class Cart < ActiveRecord::Base
  #tableless :columns => [
  #              [:product_id, :integer]]
  class_inheritable_accessor :columns
  self.columns = []
 
  #def self.comlumns()
  #  @columns ||= [];
  #end
  
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end
 
  #column :product_id, :integer 
  
  def paypal_url(return_url, _sales_items, _invoice_id)
    values = {
      :business => 'seller_1292877565_biz@gmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => _invoice_id,
      :notify_url => notify_url,
      :cert_id => "QQNHSVEBXE5DS"#"S8DUNZJY5VS3G"
    }
    _sales_items.each_with_index do |si,index|
        values.merge!({
          "amount_#{index+1}" => if si.type == SalesProduct
                                   si.product.price
                                 else
                                   si.pack.price
                                 end,    
          "item_name_#{index+1}" => if si.type == SalesProduct
                                      si.product.name
                                    else
                                      si.pack.name
                                    end,
          "item_number_#{index+1}" => if si.type == SalesProduct
                                      si.product.id
                                    else
                                      si.pack.id
                                    end,
          "quantity_#{index+1}" => si.count          
        })
    end
    #valuesi = encrypt_for_paypal(values)
    #"https://www.sandbox.paypal.com/cgi-bin/webscr?" + valuesi.to_query
    #info-encrypted 
    encrypt_for_paypal(values)    
    #"https://www.sandbox.paypal.com/cgi-bin/webscr?" #+ encrypt_for_paypal(values)
  end
  
  #info
  PAYPAL_CERT_PEM = File.read("#{Rails.root}/paypal/paypal_cert.pem")
  APP_CERT_PEM = File.read("#{Rails.root}/paypal/my-pubcert.pem")
  APP_KEY_PEM = File.read("#{Rails.root}/paypal/my-prvkey.pem")
  
  def encrypt_for_paypal(values)
    signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM), OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
    OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
  end
    
end 

"-----BEGIN PKCS7-----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-----END PKCS7-----"