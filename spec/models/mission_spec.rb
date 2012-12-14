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
    
    describe "sub mission cycle detection" do
      it "should not create/save if mission has cyclical reference" do
        mission_a = Mission.create!(title: "Sub Mission A")
        mission_b = Mission.create!(title: "Sub Mission B")
      
        mission_a.sub_embeddings.build(count: 1)
        mission_a.sub_embeddings.first.sub_mission = mission_b
        mission_a.save
      
        mission_b.sub_embeddings.build(count: 1)
        mission_b.sub_embeddings.first.sub_mission = mission_a
        
        mission_b.save.should == false
        Mission.find(mission_a._id).sub_embeddings.size.should == 1
        Mission.find(mission_b._id).sub_embeddings.size.should == 0
      end
    
      it "should not create/save if skill has cyclical reference with itself" do
        mission_a = Mission.create!(title: "Sub Mission A")
      
        mission_a.sub_embeddings.build(count: 1)
        mission_a.sub_embeddings.first.sub_mission = mission_a
        
        mission_a.save.should == false
        Mission.find(mission_a._id).sub_embeddings.size.should == 0
      end
    end
    
    describe "unique sub mission detection" do
      it "should not create/save if mission already exists" do
        mission_a = Mission.create!(title: "Mission A")
        
        sub_mission_a = Mission.create!(title: "Sub Mission A")
      
        sub_embedding_1 = mission_a.sub_embeddings.build(count: 1)
        sub_embedding_1.sub_mission = sub_mission_a
        sub_embedding_2 = mission_a.sub_embeddings.build(count: 1)
        sub_embedding_2.sub_mission = sub_mission_a

        mission_a.save.should == false
        Mission.find(mission_a._id).sub_embeddings.size.should == 0
      end
    end
    
    describe "unique mission_skill detection" do
      it "should not create/save if skill already exists" do
        mission = Mission.create!(title: "Mission")
        
        skill = Skill.create!(title: "Skill Title")
      
        mission_skill_1 = mission.mission_skills.build(points: 1)
        mission_skill_1.skill = skill
        mission_skill_2 = mission.mission_skills.build(points: 2)
        mission_skill_2.skill = skill

        mission.save.should == false
        Mission.find(mission._id).mission_skills.size.should == 0
      end
    end
  end
  
  describe "relations" do
    describe MissionEmbedding do
      it "should reference Skill Embeddings" do
        mission = Mission.new(title: "Mission Title")
        
        sub_embedding = build(:mission_embedding, count: 1, sub_mission: create(:mission))
        super_embedding = build(:mission_embedding, count: 2, super_mission: create(:mission))
        
        mission.sub_embeddings << sub_embedding
        mission.super_embeddings << super_embedding
        
        sub_embedding.save!
        super_embedding.save!
        
        mission.save!
        
        Mission.find(mission._id).sub_embeddings.first.count.should == 1
        Mission.find(mission._id).super_embeddings.first.count.should == 2
      end
      
      it "should be referenced from Mission Embedding" do
        mission = Mission.new(title: "Mission Title")
        
        sub_embedding = build(:mission_embedding, count: 1, sub_mission: create(:mission))
        super_embedding = build(:mission_embedding, count: 2, super_mission: create(:mission))
        
        mission.sub_embeddings << sub_embedding
        mission.super_embeddings << super_embedding
        
        sub_embedding.save!
        super_embedding.save!
        
        mission.save!
        
        MissionEmbedding.find(sub_embedding._id).super_mission.title.should == "Mission Title"
        MissionEmbedding.find(super_embedding._id).sub_mission.title.should == "Mission Title"
      end
    end
    
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
      
        Mission.first.mission_skills.first._id.should == mission_skill._id
      end
    
      it "should be referenced by Mission SKill" do
        mission = Mission.new(title: "Mission title", description: "A description")
       
        mission_skill = build(:mission_skill, skill: create(:skill))
        mission.mission_skills << mission_skill
      
        mission.save!
      
        MissionSkill.find(mission_skill._id).mission.title.should == "Mission title"
      end
    end
  end
  
  describe "nested attributes" do
    describe MissionSkill do
      it "should fill out mission_skill through mission_skill nested attribute" do
        mission = Mission.new(title: "A Title")
    
        create(:skill, title: "Skill A")
        create(:skill, title: "Skill B")
      
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
    
        create(:skill, title: "Skill A")
      
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
        MissionSkill.count.should == 0
      end
    end
    
    describe MissionEmbedding do
      it "should fill out sub_embedding through sub_embedding nested attribute" do
        mission = Mission.new(title: "A Title")
        Mission.create(title: "Mission A")
        Mission.create(title: "Mission B")
    
        mission.sub_embeddings_attributes = { 
          "0" => { 
            sub_mission_title: "Mission A",
            count: 10 },
          "1" => { 
            sub_mission_title: "Mission B",
            count: 9 } }
      
        mission.save!
        saved_mission = Mission.find_by(title: "A Title")
      
        saved_mission.sub_embeddings.size.should == 2
        saved_mission.sub_embeddings[0].sub_mission.title.should == "Mission A"
        saved_mission.sub_embeddings[0].count.should == 10
        saved_mission.sub_embeddings[1].sub_mission.title.should == "Mission B"
        saved_mission.sub_embeddings[1].count.should == 9
      end
    
      it "should delete using nested attributes" do
        mission = Mission.new(title: "A Title")
        Mission.create(title: "Mission A")
    
        mission.sub_embeddings_attributes = { 
          "0" => { 
            sub_mission_title: "Mission A",
            count: 10 } }
        mission.save!
       
        saved_mission = Mission.find_by(title: "A Title")
        saved_mission.sub_embeddings.size.should == 1
      
        saved_mission.sub_embeddings_attributes = { 
            "0" => { _id: saved_mission.sub_embeddings.first._id, _destroy: '1' } }
        saved_mission.save!
      
        emptied_mission = Mission.find_by(title: "Mission A")
    
        emptied_mission.sub_embeddings.size.should == 0
        MissionEmbedding.count.should == 0
      end
    end
  end
  
  describe "fields" do
    it "should be able to assign title" do
      Mission.create(title: "Mission Title")
      
      Mission.first.title.should == "Mission Title"
    end
    
    it "should be able to assign title" do
      Mission.create(title: "Mission Title", description: "Mission Description")
      
      Mission.first.description.should == "Mission Description"
    end
    
    it "should be able to mass_assign mission_skillls_attributes" do
      create(:skill, title: "Skill A")
      
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
    
    it "should be able to mass_assign mission_skillls_attributes" do
      Mission.create!(title: "Sub Mission A")
      
      Mission.create!(
        title: "Mission Title",
        sub_embeddings_attributes: {
          "0" => {
            sub_mission_title: "Sub Mission A",
            count: 10 } } )
      
      Mission.find_by(title: "Mission Title").sub_embeddings.size.should == 1
      Mission.find_by(title: "Mission Title").sub_embeddings.first.sub_mission.title.should == "Sub Mission A"
      Mission.find_by(title: "Mission Title").sub_embeddings.first.count.should == 10
    end
  end
  
  describe "points aggregation" do
    before(:each) do
      @leap_frog = Mission.create(title: "Leap Frog")
        
      @leap_frog_points = 1
  
      @leap_frogging = create(:skill, title: "Leap Frogging")
        
      leap_frog_mission_skill = @leap_frog.mission_skills.build(points: @leap_frog_points)
      leap_frog_mission_skill.skill = @leap_frogging
        
      @jump = create(:mission, title: "Jump")
      @squat = create(:mission, title: "Squat")
        
      @jumping = create(:skill, title: "Jumping")
      @squatting = create(:skill, title: "Squatting")
        
      @jump_points = 1
      @squat_points= 2
        
      jump_mission_skill = @jump.mission_skills.build(points: @jump_points)
      jump_mission_skill.skill = @jumping
      squat_mission_skill = @squat.mission_skills.build(points: @squat_points)
      squat_mission_skill.skill = @squatting

      @jump_count = 1
      @squat_count = 2
      
      jump_embedding = @leap_frog.sub_embeddings.build(count: @jump_count)
      jump_embedding.sub_mission = @jump
      squat_embedding = @leap_frog.sub_embeddings.build(count: @squat_count)
      squat_embedding.sub_mission = @squat
      
      @leap_frog.save!      
    end
    
    describe "sub mission points only" do
      it "should aggregate sub_mission_points_only without own inherent ability points" do  
        @leap_frog.sub_mission_points_only.should == { 
          "Jumping" => @jump_points * @jump_count, 
          "Squatting" => @squat_points * @squat_count }
      end
    end
    
    describe "total ability points" do
      it "should aggregate all points from all sources" do
        @leap_frog.total_ability_points.should == { 
          "Jumping" => @jump_points * @jump_count, 
          "Squatting" => @squat_points * @squat_count,
          "Leap Frogging" => @leap_frog_points }
      end
    end

    describe "associated skill names" do
      it "should aggregate all the names of skills associated with mission" do
        @leap_frog.associated_skill_names.should == ["Jumping", "Squatting", "Leap Frogging"].to_set
      end
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

  describe "Skill Levels" do
    it "should return the levels associated with the ability points for the mission" do
      #currently [1, 5, 10, 20, 50, 150, 500, 2000, 10000, 50000]
      mission = Mission.new(title: "A Title")
      
      skill_a = Skill.create!(title: "Skill A")
      skill_b = Skill.create!(title: "Skill B")
      
      mission_skill_a = mission.mission_skills.build(points: 5)
      mission_skill_a.skill = skill_a
      mission_skill_b = mission.mission_skills.build(points: 75)
      mission_skill_b.skill = skill_b
      
      mission.save!
      
      mission.skill_levels.should == { "Skill A" => 2, "Skill B" => 5 }
    end
  end
end