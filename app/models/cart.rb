class Cart < ActiveRecord::Base
  class_inheritable_accessor :columns
  self.columns = []
  
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end
  
  # to_shop_url, notificitaion_always_same, items, inv_id, name_of_subdomain  
  def paypal_url(return_url, notify_url, _sales_items, _invoice_id, _subdomain, _setting)
    values = {
      :business => _setting.email,#'seller_1292877565_biz@gmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => _invoice_id,
      :notify_url => notify_url,
      :cert_id => _setting.cert_id
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
    encrypt_for_paypal(values, _subdomain)    
  end
  
  def encrypt_for_paypal(values, subdomain)
    signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(get_APP_cert(subdomain)), OpenSSL::PKey::RSA.new(get_APP_key(subdomain), ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
    OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(get_PP_cert(subdomain))], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
  end  
  
  private
  
  def get_PP_cert(subdomain)    
    paypal_cert_pem = File.read("#{Rails.root}/paypal/#{subdomain}/paypal_cert.pem")    
  end
  
  def get_APP_cert(subdomain)
    app_cert_pem = File.read("#{Rails.root}/paypal/#{subdomain}/my-pubcert.pem")  
  end
  
  def get_APP_key(subdomain)
    app_key_pem = File.read("#{Rails.root}/paypal/#{subdomain}/my-prvkey.pem")
  end
    
end 
