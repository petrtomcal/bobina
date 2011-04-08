Given /^a user is logged in as "(.*)"$/ do |login|
  session[:user_id] = 1#User.create!(
    #:email => "test@test.com",
    #:password => 'diplomka',
    #:password_confirmation => 'diplomka'
  )

  # :create syntax for restful_authentication w/ aasm. Tweak as needed.
  # @current_user.activate! 

  visit "/login" 
  fill_in("login", :with => login) 
  fill_in("password", :with => 'diplomka') 
  click_button("Log in")
  response.body.should =~ /Logged/m  
end