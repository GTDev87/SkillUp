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
    it "should give multiple user ability to a user" do
      user = User.new(:username => "username", :email => "user@example.com", :password => "password", :password_confirmation => "password")
      
      user_ability1 = UserAbility.new(:ability => create(:ability))
      user_ability2 = UserAbility.new(:ability => create(:ability))
      
      user.user_abilities << user_ability1
      user.user_abilities << user_ability2
      
      user.save
      
      User.first.user_abilities.size.should == 2
    end
    
    it "should give multiple user mission to a user" do
      user = User.new(:username => "username", :email => "user@example.com", :password => "password", :password_confirmation => "password")
      
      user_mission1 = UserMission.new(:mission => create(:mission))
      user_mission2 = UserMission.new(:mission => create(:mission))
      
      user.user_missions << user_mission1
      user.user_missions << user_mission2
      
      user.save
      
      User.first.user_missions.size.should == 2
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