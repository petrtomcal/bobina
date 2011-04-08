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


Given /^I have login form$/ do
  pending visit "/login" 
end

Given /^I fill in email "([^"]*)"$/ do |arg1|
  fill_in("login", :with => "test@test.com")
end

Given /^I fill in password "([^"]*)"$/ do |arg1|
   fill_in("password", :with => 'diplomka') 
end

Given /^I press "([^"]*)"$/ do |arg1|
   click_button("Log in")
end

Then /^I should see "([^"]*)"$/ do |arg1|
   response.body.should =~ /Logged/m  
end
