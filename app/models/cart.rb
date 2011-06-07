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
  
  def nopaypal_url(return_url, notify_url, _sales_items, _invoice_id)
    values = {
      :business => 'seller_1292877565_biz@gmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => _invoice_id,
      :notify_url => notify_url,
      :cert_id => 'S8DUNZJY5VS3G'
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
    encrypt_for_paypal(values)
    #"https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
 
  def paypal_url(return_url, notify_url, _sales_items, _invoice_id)
    values = {
      :business => 'seller_1292877565_biz@gmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => _invoice_id,
      :notify_url => notify_url,
      :cert_id => "S8DUNZJY5VS3G"
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
    #encrypt_for_paypal(values)
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
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
