require 'spec_helper'

describe "authorization" do
  it "should show 'not authorized' when user not authorized" do
    user = create(:user)
    visit edit_user_path(user.id)
    page.should have_content("Not authorized.")
  end
  
  it "should not show 'not authorized' when user authorized" do
    user = create(:user, username: "username", password: "secret", password_confirmation: "secret")

    visit login_path
    fill_in 'sessions_email', with: user.email
    fill_in 'sessions_password', with: 'secret'
    click_button "Log In"
    
    visit edit_user_path(user.id)
    page.should_not have_content("Not authorized")
  end
  
  it "should return to same page with warning if email or password fails" do
    user = create(:user, admin: false, password: "secret", password_confirmation: "secret")

    visit login_path
    fill_in 'sessions_email', with: user.email
    fill_in 'sessions_password', with: 'wrong'
    click_button "Log In"
    
    page.should have_content("Email or password is invalid")
  end
    
  it "should go to user show if passord works" do
    user = create(:user, admin: false, password: "secret", password_confirmation: "secret")

    visit login_path
    fill_in 'sessions_email', with: user.email
    fill_in 'sessions_password', with: 'secret'
    click_button "Log In"
    
    page.should have_content("Logged in!")
  end
end