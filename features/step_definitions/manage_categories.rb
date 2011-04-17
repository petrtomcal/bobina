When /^(?:|I )follow category "([^"]*)"(?: within "([^"]*)")? for "(.+)"$/ do |link, selector, name|
  category_id = Category.find(:first, :conditions => {:name => name}).id
  with_scope(selector) do      
    find(:xpath, "//a[@href=\'/admin/categories/#{link}/#{category_id}\']").click
  end  
end

When /^I click button "(.+)"$/ do |button|
  click_button button
end

When /^I click to "(.+)"$/ do |link|
  click_link link
end
