#package steps
When /^(?:|I )follow package "([^"]*)"(?: within "([^"]*)")? for "(.+)"$/ do |link, selector, name|
  id = Pack.find(:first, :conditions => {:name => name}).id
  with_scope(selector) do      
    find(:xpath, "//a[@href=\'/admin/packs/#{link}/#{id}\']").click
  end  
end
#product steps
When /^(?:|I )follow product "([^"]*)"(?: within "([^"]*)")? for "(.+)"$/ do |link, selector, name|
  id = Product.find(:first, :conditions => {:name => name}).id

  with_scope(selector) do

    find(:xpath, "//a[@href=\'/admin/products/#{link}/#{id}\']").click
  end  
end
#in product categories
When /^(?:|I )follow categories "([^"]*)"(?: within "([^"]*)")? for "(.+)"$/ do |link, selector, name|
  id = Product.find(:first, :conditions => {:name => name}).id
  with_scope(selector) do      
    find(:xpath, "//a[@href=\'/admin/products/#{link}?product_id=#{id}\']").click
  end  
end

#in product categories
When /^(?:|I )follow product_categories "([^"]*)"(?: within "([^"]*)")? for "(.+)" and "(.+)"$/ do |link, selector, category_name, product_name|
  productid = Product.find(:first, :conditions => {:name => product_name}).id
  categoryid = Category.find(:first, :conditions => {:name => category_name}).id
  with_scope(selector) do      
    find(:xpath, "//a[@href=\'/admin/products/#{link}?category_id=#{categoryid}&product_id=#{productid}\']").click
  end  
end
