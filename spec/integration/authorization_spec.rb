require 'spec_helper'

describe "authorization" do
  it "should return to same page with warning if email or password fails" do
    visit login_path
    user = create(:user, admin: false, password: "secret", password_confirmation: "secret")

    fill_in 'email', with: user.email
    fill_in 'password', with: 'wrong'
    click_button("Log In")
    
    page.should have_content("Email or password is invalid")
  end
    
  it "should go to user show if passord works" do
    visit login_path
    user = create(:user, admin: false, password: "secret", password_confirmation: "secret")

    fill_in 'email', with: user.email
    fill_in 'password', with: 'secret'
    click_button("Log In")
    
    page.should have_content("Logged in!")
  end
end