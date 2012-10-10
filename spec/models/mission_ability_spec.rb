require 'spec_helper'

describe MissionAbility do 
  it "should create MissionAbility" do
    mission_ability = MissionAbility.new(points: 10)
    mission_ability.ability = create(:ability)
    
    create(:mission, title: "Mission Title").mission_abilities << mission_ability
    
    lambda {mission_ability.save!}.should_not raise_error
  end
  
  describe "validations" do
    it "should have a ability" do
      mission_ability = MissionAbility.new(points: 10)
    
      create(:mission, title: "Mission Title").mission_abilities << mission_ability
    
      lambda {mission_ability.save!}.should raise_error
    end
    
    it "should have level" do
      mission_ability = MissionAbility.new
      mission_ability.ability = create(:ability)
      
      create(:mission, title: "Mission Title").mission_abilities << mission_ability
    
      lambda {mission_ability.save!}.should raise_error
    end
  end
  
  describe "mass assignment" do
    it "should be able to mass assign level" do
      mission_ability = MissionAbility.new(points: 10)
      mission_ability.ability = create(:ability, title: "Ability Title")
      create(:mission).mission_abilities << mission_ability
      
      Mission.first.mission_abilities.first.points.should == 10
    end
    
    it "should be able to mass assign ability_title" do
      mission_ability = MissionAbility.new(points: 10, ability_title: "Ability Title")
      create(:mission).mission_abilities << mission_ability
      
      Mission.first.mission_abilities.first.ability.title.should == "Ability Title"
    end
  end
  
  describe "virtual attributes" do
    describe  "should query ability by title" do
      it "should find nil if ability title does not exist" do
        mission_ability = MissionAbility.new(points: 10)
      
        mission_ability.ability_title.should == nil
      end
    
      it "should find ability title if exists" do
        mission_ability = MissionAbility.new(points: 10)
      
        mission_ability.ability = create(:ability, title: "Ability Name")
      
        mission_ability.ability_title.should == "Ability Name"
      end
    
      it "find existing ability by title if exists" do
        mission_ability = MissionAbility.new(points: 10)
        
        create(:ability, title: "Existing Title")
        mission_ability.ability_title = "Existing Title"
        
        Ability.count.should == 1
        Ability.first.title == "Existing Title"
      end
    
      it "should create ability if does not exist" do
        mission_ability = MissionAbility.new(points: 10)
        
        mission_ability.ability_title = "Created Title"
        
        Ability.count.should == 1
        Ability.first.title == "Created Title"
      end
      
      it "should save ability to mission_ability when created" do
        mission = create(:mission)
        mission_ability = MissionAbility.new(points: 10)
        
        mission.mission_abilities << mission_ability
        mission_ability.ability_title = "Created Title"
        
        mission.save!
        
        Mission.first.mission_abilities[0].ability.title.should == "Created Title"
      end
    end
  end
end