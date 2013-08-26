require 'spec_helper'

describe "Logins" do
  
  it "User logs in successfully" do
  	user = FactoryGirl.create(:user)
  	visit login_path
  	
  	fill_in "email", :with => user.email
  	fill_in "password", :with => user.password
  	click_button "Sign In"
  	
  	current_path.should eq(admin_root_path)
  	page.should have_content("Dashboard")
  end
  
  it "User should not log in successfully" do
  	
  	user = FactoryGirl.create(:user)
  	
  	visit login_path
  	
  	fill_in "email", :with => user.email
  	fill_in "password", :with => nil
  	
  	click_button "Sign In"
  	
  	current_path.should eq(admin_sessions_path)
  	page.should have_content("Invalid email or password")
  	
  end
  
end