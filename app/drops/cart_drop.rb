class CartDrop < Liquid::Drop
  
  def initialize(_items)
    @product_items ||= []
    @pack_items ||= []    
    _items["products"].each_pair{ |key,value| @product_items << ProductDrop.new(Product.find(key),value) }    
    _items["collection"].each_pair{ |key,value| @pack_items << PackDrop.new(Pack.find(key),value) }
  end  
  
  def get_product_items    
    @product_items
  end
    
  def get_pack_items
    @pack_items
  end
  
  def total_count
    @product_items.map{|p| p.count.to_i}.sum + @pack_items.map{|p| p.count.to_i}.sum
  end
  
  def total_price
    @product_items.map{|p| p.price * p.count}.sum + @pack_items.map{|p| p.price * p.count}.sum
  end  
  
  def checkout_link
    "checkout link by drop"
    #link = paypal_encrypted("http://bobina.eshop.cz:3000/products/empty_cart",                                                                                       "http://bobina.eshop.cz:3000/payment_notifications/create", @sale.sales_products + @sale.sales_packs,                                                                                                @sale.token)    
    "checkout link by drop"
  end
  
  #@cart.paypal_encrypted("http://bobina.eshop.cz:3000/products/empty_cart", notify,                                                       #                        @sale.sales_products + @sale.sales_packs,                                                                       #                        @sale.token)
  
  def link
    paypal_encrypted("http://bobina.eshop.cz:3000/products/empty_cart",                                                                                       "http://bobina.eshop.cz:3000/payment_notifications/create", @sale.sales_products + @sale.sales_packs,                                                                                                @sale.token)
    
  end
  
  def paypal_encrypted(return_url, notify_url, _sales_items, _invoice_id)
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
    encrypt_for_paypal(values)
    #"https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
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