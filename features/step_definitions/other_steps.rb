#package steps
When /^(?:|I )follow package "([^"]*)"(?: within "([^"]*)")? for "(.+)"$/ do |link, selector, name|
  id = Pack.find(:first, :conditions => {:name => name}).id
  with_scope(selector) do      
    find(:xpath, "//a[@href=\'/admin/packs/#{link}/#{id}\']").click
  end  
end