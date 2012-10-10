require 'spec_helper'

describe Mission do 
  it "should create Mission" do
    mission = Mission.new(title: "A title", description: "A description")
    
    lambda {mission.save!}.should_not raise_error
  end
  
  it "should lower title's case after creation" do
    mission = Mission.create(title: "lOwErCaSe TiTlE", description: "A description")
    
    mission.lowercase_title.should == "lowercase title"
  end

  it "should search title by lowercase_title" do
    Mission.create(title: "case")
    Mission.create(title: "InCaSe")
    Mission.create(title: "cases")
    Mission.create(title: "UPPER CASE")
    Mission.create(title: "other word")
    
    Mission.search_titles("case").map{ |mission| mission.title }.should == ["case", "cases", "InCaSe", "UPPER CASE"]
  end

  describe "validation" do
    it "should require that Missions have titles" do
      mission = Mission.new(description: "A description")
    
      lambda {mission.save!}.should raise_error
    end
  end
  
  describe "relations" do
    it "should give multiple mission abilies to a mission" do
      mission = Mission.new(title: "A title", description: "A description")
      
      mission.mission_abilities << build(:mission_ability, ability: create(:ability))
      mission.mission_abilities << build(:mission_ability, ability: create(:ability))
      
      mission.save!
      
      Mission.first.mission_abilities.size.should == 2
    end
  end
  
  describe "nested attributes" do
    it "should fill out mission_ability through mission_ability nested attribute" do
      mission = Mission.new(title: "A Title")
    
      mission.mission_abilities_attributes = { 
        "0" => { 
          ability_title: "Ability A",
          points: 10 },
        "1" => { 
          ability_title: "Ability B",
          points: 9 } }
      
      mission.save!
      saved_mission = Mission.first
      
      saved_mission.mission_abilities.size.should == 2
      saved_mission.mission_abilities[0].ability.title.should == "Ability A"
      saved_mission.mission_abilities[0].points.should == 10
      saved_mission.mission_abilities[1].ability.title.should == "Ability B"
      saved_mission.mission_abilities[1].points.should == 9
    end
    
    it "should delete using nested attributes" do
      mission = Mission.new(title: "A Title")
    
      mission.mission_abilities_attributes = { 
        "0" => { 
          ability_title: "Ability A",
          points: 10 } }
      mission.save!
      
      saved_mission = Mission.first
      saved_mission.mission_abilities.size.should == 1
      
      saved_mission.mission_abilities_attributes = { 
          "0" => { _id: saved_mission.mission_abilities.first._id, _destroy: '1' } }
      saved_mission.save!
      
      emptied_mission = Mission.first
    
      emptied_mission.mission_abilities.size.should == 0
    end
  end
  
  describe "mass assignment" do
    it "should be able to mass assign title" do
      Mission.create(title: "Mission Title")
      
      Mission.first.title.should == "Mission Title"
    end
    
    it "should be able to mass_assign mission_abilities_attributes" do
      Mission.create!(
        title: "Mission Title", 
        mission_abilities_attributes: {
          "0" => {
            ability_title: "Ability A",
            points: 10 } } )
      
      Mission.first.mission_abilities.size.should == 1
      Mission.first.mission_abilities.first.ability.title.should == "Ability A"
      Mission.first.mission_abilities.first.points.should == 10
    end
  end
end