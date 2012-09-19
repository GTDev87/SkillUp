require 'spec_helper'

describe MissionAbility do 
  it "should create MissionAbility" do
    mission_ability = MissionAbility.new(:level => 10, :ability => create(:ability))
    mission = Mission.new(:title => "Mission Title")
    
    mission.mission_abilities << mission_ability
    
    mission_ability.save.should be_true
  end
  
  describe "validations" do
    it "should have a ability" do
      mission_ability = MissionAbility.new(:level => 10)
      mission = Mission.new(:title => "Mission Title")
    
      mission.mission_abilities << mission_ability
    
      mission_ability.save.should be_false
    end
  end
end