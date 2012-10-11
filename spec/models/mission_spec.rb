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
    it "should give multiple mission skills to a mission" do
      mission = Mission.new(title: "A title", description: "A description")
      
      mission.mission_skills << build(:mission_skill, skill: create(:skill))
      mission.mission_skills << build(:mission_skill, skill: create(:skill))
      
      mission.save!
      
      Mission.first.mission_skills.size.should == 2
    end
  end
  
  describe "nested attributes" do
    it "should fill out mission_skill through mission_skill nested attribute" do
      mission = Mission.new(title: "A Title")
    
      mission.mission_skills_attributes = { 
        "0" => { 
          skill_title: "Skill A",
          points: 10 },
        "1" => { 
          skill_title: "Skill B",
          points: 9 } }
      
      mission.save!
      saved_mission = Mission.first
      
      saved_mission.mission_skills.size.should == 2
      saved_mission.mission_skills[0].skill.title.should == "Skill A"
      saved_mission.mission_skills[0].points.should == 10
      saved_mission.mission_skills[1].skill.title.should == "Skill B"
      saved_mission.mission_skills[1].points.should == 9
    end
    
    it "should delete using nested attributes" do
      mission = Mission.new(title: "A Title")
    
      mission.mission_skills_attributes = { 
        "0" => { 
          skill_title: "Skill A",
          points: 10 } }
      mission.save!
      
      saved_mission = Mission.first
      saved_mission.mission_skills.size.should == 1
      
      saved_mission.mission_skills_attributes = { 
          "0" => { _id: saved_mission.mission_skills.first._id, _destroy: '1' } }
      saved_mission.save!
      
      emptied_mission = Mission.first
    
      emptied_mission.mission_skills.size.should == 0
    end
  end
  
  describe "mass assignment" do
    it "should be able to mass assign title" do
      Mission.create(title: "Mission Title")
      
      Mission.first.title.should == "Mission Title"
    end
    
    it "should be able to mass_assign mission_skillls_attributes" do
      Mission.create!(
        title: "Mission Title", 
        mission_skills_attributes: {
          "0" => {
            skill_title: "Skill A",
            points: 10 } } )
      
      Mission.first.mission_skills.size.should == 1
      Mission.first.mission_skills.first.skill.title.should == "Skill A"
      Mission.first.mission_skills.first.points.should == 10
    end
  end
end