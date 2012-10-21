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
    describe MissionSkill do
      it "should give multiple mission skills to a mission" do
        mission = Mission.new(title: "A title", description: "A description")
      
        mission.mission_skills << build(:mission_skill, skill: create(:skill))
        mission.mission_skills << build(:mission_skill, skill: create(:skill))
      
        mission.save!
       
        Mission.first.mission_skills.size.should == 2
      end
    
      it "should reference Mission SKill" do
        mission = Mission.new(title: "A title", description: "A description")
      
        mission_skill = build(:mission_skill, skill: create(:skill))
        mission.mission_skills << mission_skill
      
        mission.save!
      
        Mission.first.mission_skills.first._id == mission_skill._id
      end
    
      it "should be referenced by Mission SKill" do
        mission = Mission.new(title: "Mission title", description: "A description")
       
        mission_skill = build(:mission_skill, skill: create(:skill))
        mission.mission_skills << mission_skill
      
        mission.save!
      
        MissionSkill.find(mission_skill._id).mission.title == "Mission title"
      end
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
    
    it "should be able to mass assign title" do
      Mission.create(title: "Mission Title", description: "Mission Description")
      
      Mission.first.description.should == "Mission Description"
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
  
  describe "skill points" do
    it "should aggregate skill_points" do
      mission = Mission.new(title: "A Title")
      
      skill_a = Skill.create!(title: "Skill A")
      skill_b = Skill.create!(title: "Skill B")
      
      mission_skill_a = mission.mission_skills.build(points: 5)
      mission_skill_a.skill = skill_a
      mission_skill_b = mission.mission_skills.build(points: 9)
      mission_skill_b.skill = skill_b
      
      mission.save!
      
      mission.skill_points.should == { "Skill A" => 5, "Skill B" => 9 }
    end
  end
  
  describe "ability points" do
    it "should aggregate ability_points" do
      mission = Mission.new(title: "A Title")
      
      skill_a = Skill.create!(title: "Skill A")
      skill_b = Skill.create!(title: "Skill B")
      
      sub_skill_a = Skill.create!(title: "Sub Skill A")
      sub_skill_b = Skill.create!(title: "Sub Skill B")
      sub_skill_c = Skill.create!(title: "Sub Skill C")
      
      mission_a_points = 1
      mission_b_points = 2
      
      mission_skill_a = mission.mission_skills.build(points: mission_a_points)
      mission_skill_a.skill = skill_a
      mission_skill_b = mission.mission_skills.build(points: mission_b_points)
      mission_skill_b.skill = skill_b
     
      mission.save!
      
      sub_embedding_aa_points = 1
      sub_embedding_ab_points = 2
      sub_embedding_bb_points = 3
      sub_embedding_bc_points = 4
      
      sub_embedding_aa = skill_a.sub_embeddings.build(weight: sub_embedding_aa_points)
      sub_embedding_aa.sub_skill = sub_skill_a
      sub_embedding_ab = skill_a.sub_embeddings.build(weight: sub_embedding_ab_points)
      sub_embedding_ab.sub_skill = sub_skill_b
      
      sub_embedding_bb = skill_b.sub_embeddings.build(weight: sub_embedding_bb_points)
      sub_embedding_bb.sub_skill = sub_skill_b
      sub_embedding_bc = skill_b.sub_embeddings.build(weight: sub_embedding_bc_points)
      sub_embedding_bc.sub_skill = sub_skill_c
  
      skill_a.save!
      skill_b.save!
      
      skill_a_expected_points = mission_a_points
      skill_b_expected_points = mission_b_points
      
      sub_skill_a_expected_points = mission_a_points * sub_embedding_aa_points
      sub_skill_b_expected_points = mission_a_points * sub_embedding_ab_points + mission_b_points * sub_embedding_bb_points
      sub_skill_c_expected_points = mission_b_points * sub_embedding_bc_points
      
      mission.ability_points.should == { 
        "Skill A" => skill_a_expected_points, 
        "Skill B" => skill_b_expected_points,
        "Sub Skill A" => sub_skill_a_expected_points, 
        "Sub Skill B" => sub_skill_b_expected_points, 
        "Sub Skill C" => sub_skill_c_expected_points }
    end
  end
end