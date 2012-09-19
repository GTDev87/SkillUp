require 'spec_helper'

describe User do 
  it "should create User" do
    user = User.new(:username => "username", :email => "user@example.com", :password => "password", :password_confirmation => "password")
    
    user.save.should be_true
  end
  
  describe "validation" do
    it "should require that User have username" do
      user = User.new(:email => "user@example.com", :password => "password", :password_confirmation => "password")
    
      user.save.should be_false
    end
    
    it "should require username uniqueness" do
      User.create(:username => "username",:email => "user@example.com", :password => "password", :password_confirmation => "password")
      user = User.new(:username => "username",:email => "otherUser@example.com", :password => "password", :password_confirmation => "password")
    
      user.save.should be_false
    end
    
    it "should require that User have email" do
      user = User.new(:username => "username", :password => "password", :password_confirmation => "password")
    
      user.save.should be_false
    end
    
    it "should require email uniqueness" do
      User.create(:username => "username",:email => "user@example.com", :password => "password", :password_confirmation => "password")
      user = User.new(:username => "otherUsername",:email => "user@example.com", :password => "password", :password_confirmation => "password")
    
      user.save.should be_false
    end
  end
  
  describe "relations" do
    it "should give multiple skill inherents to a user" do
      user = User.new(:username => "username", :email => "user@example.com", :password => "password", :password_confirmation => "password")
      
      skill_inherent1 = SkillInherent.new(:skill => create(:skill))
      skill_inherent2 = SkillInherent.new(:skill => create(:skill))
      
      user.skill_inherents << skill_inherent1
      user.skill_inherents << skill_inherent2
      
      user.save
      
      User.first.skill_inherents.size.should == 2
    end
    
    it "should give multiple tasks to a user" do
      user = User.new(:username => "username", :email => "user@example.com", :password => "password", :password_confirmation => "password")
      
      task1 = Task.new(:mission => create(:mission))
      task2 = Task.new(:mission => create(:mission))
      
      user.tasks << task2
      user.tasks << task2
      
      user.save
      
      User.first.tasks.size.should == 2
    end
  end
  
  describe "password authentication" do
    it "should require password and confirmation matching" do
      user = User.new(:username => "username", :email => "user@example.com", :password => "password", :password_confirmation => "not password")
    
      user.save.should be_false
    end
  end
  
  describe "locating user by email" do
    it "should find user by unique email" do
      User.create(:username => "username", :email => "user@example.com", :password => "password", :password_confirmation => "password")
      user = User.find_by_email("user@example.com")
      
      user.username.should == "username"
      user.email.should == "user@example.com"
    end
  end
end