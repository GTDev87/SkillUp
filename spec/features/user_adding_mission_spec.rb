require 'spec_helper'

describe "adding mission" do
  it "should create a mission and add it to user when user adds non existing mission", js: true do
    visit login_path
    user = create(:user, admin: false, password: "secret", password_confirmation: "secret")

    fill_in 'sessions_email', with: user.email
    fill_in 'sessions_password', with: 'secret'
    click_button "Log In"
    
    click_link 'Add Task'
    find(:css, "input[id^='user_user_missions_attributes_'][id$='_mission_title']").set("Test Title")
    click_button "Save Tasks"
    
    user.reload
    
    user.user_missions.size.should == 1
    Mission.first.title.should == "Test Title"
    
    page.should have_content("Test Title")
  end
end