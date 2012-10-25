require 'spec_helper'

describe MissionSkill do 
  it "should create MissionSkill" do
    mission_skill = MissionSkill.new(points: 10)
    mission_skill.skill = create(:skill)
    
    create(:mission, title: "Mission Title").mission_skills << mission_skill
    
    lambda {mission_skill.save!}.should_not raise_error
  end
  
  describe "validations" do
    it "should have a skill" do
      mission_skill = MissionSkill.new(points: 10)
    
      create(:mission, title: "Mission Title").mission_skills << mission_skill
    
      lambda {mission_skill.save!}.should raise_error
    end
    
    it "should have a mission" do
      mission_skill = MissionSkill.new(points: 10)
      mission_skill.skill = create(:skill)
    
      lambda {mission_skill.save!}.should raise_error
    end
    
    it "should have level" do
      mission_skill = MissionSkill.new
      mission_skill.skill = create(:skill)
      
      create(:mission, title: "Mission Title").mission_skills << mission_skill
    
      lambda {mission_skill.save!}.should raise_error
    end
  end
  
  describe "relations" do
    describe Skill do
      it "should reference Skill" do
        mission_skill = MissionSkill.new(points: 10)
        mission_skill.skill = create(:skill, title: "Skill Title")
        mission_skill.mission = create(:mission, title: "Mission Title")
        mission_skill.save!
      
        MissionSkill.first.skill.title.should == "Skill Title"
      end
      
      it "should be referenced by Skill" do
        mission_skill = MissionSkill.new(points: 10)
        mission_skill.skill = create(:skill, title: "Skill Title")
        mission_skill.mission = create(:mission, title: "Mission Title")
        mission_skill.save!
      
        Skill.first.mission_skills.first.points.should == 10
      end
    end
    
    describe Mission do
      it "should reference Mission" do
        mission_skill = MissionSkill.new(points: 10)
        mission_skill.skill = create(:skill, title: "Skill Title")
        mission_skill.mission = create(:mission, title: "Mission Title")
        mission_skill.save!
      
        MissionSkill.first.mission.title.should == "Mission Title"
      end
      
      it "should be referenced by Mission" do
        mission_skill = MissionSkill.new(points: 10)
        mission_skill.skill = create(:skill, title: "Skill Title")
        mission_skill.mission = create(:mission, title: "Mission Title")
        mission_skill.save!
      
        Mission.first.mission_skills.first.points.should == 10
      end
    end
  end
  
  describe "mass assignment" do
    it "should be able to mass assign points" do
      mission_skill = MissionSkill.new(points: 10)
      mission_skill.skill = create(:skill, title: "Skill Title")
      create(:mission).mission_skills << mission_skill
      
      Mission.first.mission_skills.first.points.should == 10
    end
    
    it "should be able to mass assign skill_title" do
      create(:skill, title: "Skill Title")
      mission_skill = MissionSkill.new(points: 10, skill_title: "Skill Title")
      create(:mission).mission_skills << mission_skill
      
      Mission.first.mission_skills.first.skill.title.should == "Skill Title"
    end
  end
  
  describe "virtual attributes" do
    describe  "should query skill by title" do
      it "should find nil if skill title does not exist" do
        mission_skill = MissionSkill.new(points: 10)
      
        mission_skill.skill_title.should == nil
      end
    
      it "should find skill title if exists" do
        mission_skill = MissionSkill.new(points: 10)
      
        mission_skill.skill = create(:skill, title: "Skill Name")
      
        mission_skill.skill_title.should == "Skill Name"
      end
    
      it "find existing skill by title if exists" do
        mission_skill = MissionSkill.new(points: 10)
        
        create(:skill, title: "Existing Title")
        mission_skill.skill_title = "Existing Title"
        
        Skill.count.should == 1
        Skill.first.title == "Existing Title"
      end
      
      it "should save skill to mission_skill when created" do
        mission = create(:mission)
        create(:skill, title: "Created Title")
        mission_skill = MissionSkill.new(points: 10)
        
        mission.mission_skills << mission_skill
        mission_skill.skill_title = "Created Title"
        
        mission.save!
        
        Mission.first.mission_skills.first.skill.title.should == "Created Title"
      end
    end
  end
end