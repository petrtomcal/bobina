#Given /^a user is logged in as "(.*)"$/ do |login|
#  session[:user_id] = 1#User.create!(
#    #:email => "test@test.com",
#    #:password => 'diplomka',
#    #:password_confirmation => 'diplomka'
#  )
#
#  # :create syntax for restful_authentication w/ aasm. Tweak as needed.
#  # @current_user.activate! 
#
#  visit "/login" 
#  fill_in("login", :with => login) 
#  fill_in("password", :with => 'diplomka') 
#  click_button("Log in")
#  response.body.should =~ /Logged/m  
#end

When /^I visit user page "(.+)" for "(.+)"$/ do |action, email|
  user = User.find(:first, :conditions => {:email => email})  
  visit url_for(:controller => 'admin/users', :action => action, :id => user.id)  
end

When /^(?:|I )follow "([^"]*)"(?: within "([^"]*)")? for "(.+)"$/ do |link, selector, email|
  user_id = User.find(:first, :conditions => {:email => email}).id
  #save_and_open_page
  #page.all('a').first[:href]
  #page.find('a')[:href]=="/admin/users/edit/id"
  #find(:xpath, "//a[@href=\'/admin/users/edit/id\']").click
  with_scope(selector) do      
    find(:xpath, "//a[@href=\'/admin/users/#{link}/#{user_id}\']").click
  end  
end

When /^I fill form/ do
  #save_and_open_page
  fill_in 'email', :with => 'test@test.cz'
  fill_in 'password_hash', :with => 'diplomka'  
end

When /^I click button "(.+)"$/ do |button|
  click_button button
end

When /^I click to users/ do
  click_link 'Users'
end

Given /^I pick answer "([^\"]+)"$/ do |value|
  selector = %{//div[@data-value="#{value}"]}
  error_message = "Could not find answer for value '#{value}'."
  page.locate(:xpath, selector, error_message).click
end

Given /^a confirmation box saying "([^\"]*)" should pop up$/ do |message|
  @expected_message = message
end

Given /^I want to click "([^\"]*)"$/ do |option|
  retval = (option == "Ok") ? "true" : "false"

  page.evaluate_script("window.confirm = function (msg) {
    $.cookie('confirm_message', msg)
    return #{retval}
  }")
end

#Then /^"([^\"]*)" should link to "([^\"]*)"(?: within "([^\"]*)")/ do |text, link_text, container|
#  with_scope(container) do
#    URI.parse(page.find_link(link_text)['href']).path.should == path_to(page_name)
#    puts URI.parse(page.find_link(link_text)['href']).path.should
#  end
#end

#Then /^(?:|I )should see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
#  save_and_open_page    
#  with_scope(selector) do
#    if page.respond_to? :should
#      page.should have_content(text)
#    else
#      assert page.has_content?(text)
#    end
#  end  
#end

Then /^I click \('test@test\.cz'\)$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^"([^\"]*)" should link to "([^\"]*)"(?: within "([^\"]*)")?$/ do |link_text, page_name, container|
  with_scope(container) do
    URI.parse(page.find_link(link_text)['href']).path.should == path_to(page_name)
  end
end

#Then /^I should link to "([^\"]*)"(?: within "([^\"]*)")$/ do |link_text,page_name, container|
#  with_scope(container) do
#    URI.parse(page.find_link(link_text)['href']).path.should == path_to(page_name)
#  end
#end
#Then /^I"([^\"]*)" should link to "([^\"]*)"(?: within "([^\"]*)")$/ do |link_text,page_name, container|
#  with_scope(container) do
#    URI.parse(page.find_link(link_text)['href']).path.should == path_to(page_name)
#  end
#end

#When /I sign in/ do
#  visit('/')
#  within(:css, "form") do
#    fill_in 'Email', :with => 'test@test.com'
#    fill_in 'Password', :with => 'diplomka'
#  end
#  click_button 'Login'
#end
#Given /^I have login form$/ do
#  pending visit "/login" 
#end
#
#Given /^I fill in email "([^"]*)"$/ do |arg1|
#  fill_in("login", :with => "test@test.com")
#end
#
#Given /^I fill in password "([^"]*)"$/ do |arg1|
#   fill_in("password", :with => 'diplomka') 
#end
#
#Given /^I press "([^"]*)"$/ do |arg1|
#   click_button("Log in")
#end
#
#Then /^I should see "([^\"]*)"$/ do |arg1|     
#   response.body.should =~ /Logged/m  
#end
#
#Then /^I click to user$/ do
#  pending # express the regexp above with the code you wish you had
#end
#
#Then /^I should see list of users$/ do
#  pending # express the regexp above with the code you wish you had
#end