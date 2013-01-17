require 'spec_helper'

describe "Home Controller" do
  
  it "Renders home page" do
    visit "/"
    #response.code.should == "200"
    current_path.should == "/"
  end
  
  it "Page has 'Welcome' in content" do
    visit "/"
    page.should have_content "Welcome"
  end
  
  it "Page has 'Welcome' in content" do
    user_login
    visit "/"
    click_link 'Recent'
    page.should have_content "Recent"
  end
  
end