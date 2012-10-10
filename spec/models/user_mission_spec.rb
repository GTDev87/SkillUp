require 'spec_helper'

describe UserMission do 
  it "should create UserMission" do
    user_mission = UserMission.new
    create(:user).user_missions << user_mission
    user_mission.mission = create(:mission)
    
    lambda {user_mission.save!}.should_not raise_error
  end
  
  describe "validations" do
    it "should have a mission" do
      user_mission = UserMission.new
      create(:user).user_missions << user_mission
    
      lambda {user_mission.save!}.should raise_error
    end
  end
  
  describe "mass assignment" do
    it "should be able to mass assignm mission_title" do
      user_mission = UserMission.new(mission_title: "Mission Title")
      create(:user).user_missions << user_mission
    
      User.first.user_missions.first.mission.title.should == "Mission Title"
    end
  end
  
  describe "virtual attributes" do
    describe  "should query mission by title" do
      it "should find nil if mission title does not exist" do
        user_mission = UserMission.new
      
        user_mission.mission_title.should == nil
      end
    
      it "should find mission title if exists" do
        user_mission = UserMission.new
      
        user_mission.mission = create(:mission, title: "Mission Name")
      
        user_mission.mission_title.should == "Mission Name"
      end
    
      it "find existing mission by title if exists" do
        user_mission = UserMission.new
        
        create(:mission, title: "Existing Title")
        user_mission.mission_title = "Existing Title"
        
        Mission.count.should == 1
        Mission.first.title == "Existing Title"
      end
    
      it "should create mission if does not exist" do
        user_mission = UserMission.new
        
        user_mission.mission_title = "Created Title"
        
        Mission.count.should == 1
        Mission.first.title == "Created Title"
      end
      
      it "should save mission to user_mission when created" do
        user = create(:user)
        user_mission = UserMission.new
        
        user.user_missions << user_mission
        user_mission.mission_title = "Created Title"
        
        user.save!
        
        User.first.user_missions[0].mission.title.should == "Created Title"
      end
    end
  end
end
