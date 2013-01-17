require 'spec_helper'

def user_login
  
  test_user = User.find_by_email('test@test.com') || User.create(:email => 'test@test.com', :password => 'tester')
  visit "/users/sign_in"
  
  within "#login-content" do
    fill_in 'user_email',    :with => 'test@test.com'
    fill_in 'user_password', :with => 'tester'
    click_on 'Sign in'
  end
end