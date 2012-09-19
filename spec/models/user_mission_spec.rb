require 'spec_helper'

describe UserMission do 
  it "should create UserMission" do
    user_mission = UserMission.new(:mission => create(:mission))
    user = User.new(:username => "username", :email => "user@email.com")
    
    user.user_missions << user_mission
    
    user_mission.save.should be_true
  end
  
  describe "validations" do
    it "should have a mission" do
      user_mission = UserMission.new
      user = User.new(:username => "username", :email => "user@email.com")
    
      user.user_missions << user_mission
    
      user_mission.save.should be_false
    end
  end
end
