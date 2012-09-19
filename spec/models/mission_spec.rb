require 'spec_helper'

describe Mission do 
  it "should create Mission" do
    mission = Mission.new(:title => "A title", :description => "A description")
    
    mission.save.should be_true
  end
  
  describe "validation" do
    it "should require that Missions have titles" do
      mission = Mission.new(:description => "A description")
    
      mission.save.should be_false
    end
  end
  
  describe "relations" do
    it "should give multiple mission abilies to a mission" do
      mission = Mission.new(:title => "A title", :description => "A description")
      
      mission_ability1 = MissionAbility.new(:ability => create(:ability))
      mission_ability2 = MissionAbility.new(:ability => create(:ability))
      
      mission.mission_abilities << mission_ability1
      mission.mission_abilities << mission_ability2
      
      mission.save
      
      Mission.first.mission_abilities.size.should == 2
    end
  end
end