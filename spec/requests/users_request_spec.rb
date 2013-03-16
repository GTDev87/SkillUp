require 'spec_helper'

describe UsersController do
  describe "editing password" do
    it "should should not update password if blank" do
      user = create(:user, admin: false, password: "secret", password_confirmation: "secret")

      old_password_digest = user.password_digest
    
      post sessions_path, sessions: {email: user.email, password: "secret"}
      put user_path(user.id), user: { password: "", password_confirmation: "" }
    
      updated_user = User.find_by_email(user.email)
      updated_user.password_digest.should == old_password_digest
    end
  
    it "should not update user if confirmation does not exist" do
      user = create(:user, admin: false, password: "secret", password_confirmation: "secret")

      old_password_digest = user.password_digest
     
      post sessions_path, sessions: {email: user.email, password: "secret"}
      put user_path(user.id), user: { password: "abc", password_confirmation: "" }
    
      updated_user = User.find_by_email(user.email)
      updated_user.password_digest.should == old_password_digest
    end
  
    it "should not update user if confirmation only has data" do
      user = create(:user, admin: false, password: "secret", password_confirmation: "secret")

      old_password_digest = user.password_digest
    
      post sessions_path, sessions: {email: user.email, password: "secret"}
      put user_path(user.id), user: { password: "", password_confirmation: "abc" }
    
      updated_user = User.find_by_email(user.email)
      updated_user.password_digest.should == old_password_digest
    end
  
    it "should update password user if confirmation is same" do
      user = create(:user, admin: false, password: "secret", password_confirmation: "secret")
  
      old_password_digest = user.password_digest
    
      post sessions_path, sessions: {email: user.email, password: "secret"}
      put user_path(user.id), user: { password: "abc", password_confirmation: "abc" }
    
      updated_user = User.find_by_email(user.email)
      updated_user.password_digest.should_not == old_password_digest
    end
  end
  
  describe "authentication" do
    it "should authorized user to change own fields" do
      user = create(:user, username: "username", password: "secret", password_confirmation: "secret")
      post sessions_path, sessions: {email: user.email, password: "secret"}
    
      put user_path(user.id), user: { username: "newusername" }
      
      saved_user = User.last
      saved_user.username.should eq("newusername")
    end
  
    it "should not_authorized user to change admin" do
      user = create(:user, username: "username", password: "secret", password_confirmation: "secret")
      post sessions_path, sessions: {email: user.email, password: "secret"}
    
      put user_path(user.id), user: { admin: "1" }
      
      saved_user = User.last
      saved_user.admin.should_not be_true
    end
    
    it "should not authorized guest to change users fields" do
      user = create(:user, username: "username", password: "secret", password_confirmation: "secret")
    
      put user_path(user.id), user: { username: "newusername" }
      
      saved_user = User.last
      saved_user.username.should eq("username")
    end
  
    it "should not authorized user to change otherusers fields" do
      user = create(:user, username: "username", password: "secret", password_confirmation: "secret")
      other_user = create(:user, username: "otherusername", password: "secret", password_confirmation: "secret")
      post sessions_path, sessions: {email: user.email, password: "secret"}
      
      put user_path(user.id), user: { username: "newusername" }
       
      saved_other_user = User.find_by_email(other_user.email)
      saved_other_user.username.should eq("otherusername")
    end
  end
end