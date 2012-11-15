require 'spec_helper'

describe Skill do 
  it "should create Skill" do
    skill = Skill.new(title: "A title", description: "A description")
    
    lambda {skill.save!}.should_not raise_error
  end
  
  it "should lower title's case after creation" do
    skill = Skill.create(title: "lOwErCaSe TiTlE", description: "A description")
    
    skill.lowercase_title.should == "lowercase title"
  end
  
  it "should search title by lowercase_title" do
    Skill.create(title: "case")
    Skill.create(title: "InCaSe")
    Skill.create(title: "cases")
    Skill.create(title: "UPPER CASE")
    Skill.create(title: "other word")
    
    Skill.search_titles("case").map{ |skill| skill.title }.should == ["case", "cases", "InCaSe", "UPPER CASE"]
  end
  
  describe "validation" do
    it "should require that Skill have titles" do
      skill = Skill.new(description: "A description")
    
      lambda {skill.save!}.should raise_error
    end
    
    describe "sub skill cycle detection" do
      it "should not create/save if skill has cyclical reference" do
        skill_a = Skill.create!(title: "Sub Skill A")
        skill_b = Skill.create!(title: "Sub Skill B")
      
        skill_a.sub_embeddings.build(weight: 1)
        skill_a.sub_embeddings.first.sub_skill = skill_b
        skill_a.save
      
        skill_b.sub_embeddings.build(weight: 1)
        skill_b.sub_embeddings.first.sub_skill = skill_a
        
        skill_b.save.should == false
        Skill.find(skill_a._id).sub_embeddings.size.should == 1
        Skill.find(skill_b._id).sub_embeddings.size.should == 0
      end
    
      it "should not create/save if skill has cyclical reference with itself" do
        skill_a = Skill.create!(title: "Sub Skill A")
      
        skill_a.sub_embeddings.build(weight: 1)
        skill_a.sub_embeddings.first.sub_skill = skill_a
        
        skill_a.save.should == false
        Skill.find(skill_a._id).sub_embeddings.size.should == 0
      end
    end
    
    describe "unique subskill detection" do
      it "should not create/save if skill already exists" do
        skill_a = Skill.create!(title: "Skill A")
        
        sub_skill_a = Skill.create!(title: "Sub Skill A")
      
        sub_embedding_1 = skill_a.sub_embeddings.build(weight: 1)
        sub_embedding_1.sub_skill = sub_skill_a
        sub_embedding_2 = skill_a.sub_embeddings.build(weight: 1)
        sub_embedding_2.sub_skill = sub_skill_a

        skill_a.save.should == false
        Skill.find(skill_a._id).sub_embeddings.size.should == 0
      end
    end
  end
  
  describe "relations" do
    describe SkillEmbedding do
      it "should reference Skill Embeddings" do
        skill = Skill.new(title: "Skill Title")
        
        sub_embedding = build(:skill_embedding, weight: 1, sub_skill: create(:skill))
        super_embedding = build(:skill_embedding, weight: 2, super_skill: create(:skill))
        
        skill.sub_embeddings << sub_embedding
        skill.super_embeddings << super_embedding
        
        sub_embedding.save!
        super_embedding.save!
        
        skill.save!
        
        Skill.find(skill._id).sub_embeddings.first.weight.should == 1
        Skill.find(skill._id).super_embeddings.first.weight.should == 2
      end
      
      it "should be referenced from Skill Embedding" do
        skill = Skill.new(title: "Skill Title")
        
        sub_embedding = build(:skill_embedding, weight: 1, sub_skill: create(:skill))
        super_embedding = build(:skill_embedding, weight: 2, super_skill: create(:skill))
        
        skill.sub_embeddings << sub_embedding
        skill.super_embeddings << super_embedding
        
        sub_embedding.save!
        super_embedding.save!
        
        skill.save!
        
        SkillEmbedding.find(sub_embedding._id).super_skill.title.should == "Skill Title"
        SkillEmbedding.find(super_embedding._id).sub_skill.title.should == "Skill Title"
      end
    end
    
    describe MissionSkill do
      it "should give multiple mission skills to a mission" do
        skill = Skill.new(title: "A title", description: "A description")
      
        mission_skill_1 = build(:mission_skill, mission: create(:mission))
        mission_skill_1.mission = create(:mission)
        
        mission_skill_2 = build(:mission_skill, mission: create(:mission))
        mission_skill_2.mission = create(:mission)
        
        skill.mission_skills << mission_skill_1
        skill.mission_skills << mission_skill_2
        
        mission_skill_1.save!
        mission_skill_2.save!
        skill.save!
       
        Skill.first.mission_skills.size.should == 2
      end
    
      it "should reference Mission SKill" do
        skill = Skill.new(title: "A title", description: "A description")
      
        mission_skill = build(:mission_skill, mission: create(:mission))
        mission_skill.mission = create(:mission)        
        skill.mission_skills << mission_skill
        
        mission_skill.save!
        skill.save!
      
        Skill.first.mission_skills.first._id == mission_skill._id
      end
    
      it "should be referenced by Mission SKill" do
        skill = Skill.new(title: "Skill title", description: "A description")
      
        mission_skill = build(:mission_skill, mission: create(:mission))
        mission_skill.mission = create(:mission)        
        skill.mission_skills << mission_skill
        
        mission_skill.save!
        skill.save!
      
        MissionSkill.find(mission_skill._id).skill.title == "Skill title"
      end
    end
  end
  
  describe "fields" do
    it "should be able to assign title" do
      Skill.create!(title: "Skill Title", description: "A description")
      
      Skill.first.title.should == "Skill Title"
    end
    
    it "should be able to assign description" do
      Skill.create!(title: "Skill Title", description: "A description")
      
      Skill.first.description.should == "A description"
    end
    
    it "should be able to assign sub_embeddings" do
      Skill.create!(title: "Skill A")
      Skill.create!(
      title: "Skill Title", 
      description: "A description",
      sub_embeddings_attributes: {
        "0" => {
          sub_skill_title: "Skill A",
          weight: 10 } } )
      
      Skill.find_by(title: "Skill Title").sub_embeddings.size.should == 1
      Skill.find_by(title: "Skill Title").sub_embeddings.first.sub_skill.title.should == "Skill A"
      Skill.find_by(title: "Skill Title").sub_embeddings.first.weight.should == 10
    end
  end
  
  describe "nested attributes" do
    describe SkillEmbedding do
      it "should fill out sub_embedding through sub_embedding nested attribute" do
        skill = Skill.new(title: "A Title")
        Skill.create(title: "Skill A")
        Skill.create(title: "Skill B")
    
        skill.sub_embeddings_attributes = { 
          "0" => { 
            sub_skill_title: "Skill A",
            weight: 10 },
          "1" => { 
            sub_skill_title: "Skill B",
            weight: 9 } }
      
        skill.save!
        saved_skill = Skill.find_by(title: "A Title")
      
        saved_skill.sub_embeddings.size.should == 2
        saved_skill.sub_embeddings[0].sub_skill.title.should == "Skill A"
        saved_skill.sub_embeddings[0].weight.should == 10
        saved_skill.sub_embeddings[1].sub_skill.title.should == "Skill B"
        saved_skill.sub_embeddings[1].weight.should == 9
      end
    
      it "should delete using nested attributes" do
        skill = Skill.new(title: "A Title")
        Skill.create(title: "Skill A")
    
        skill.sub_embeddings_attributes = { 
          "0" => { 
            sub_skill_title: "Skill A",
            weight: 10 } }
        skill.save!
      
        saved_skill = Skill.find_by(title: "A Title")
        saved_skill.sub_embeddings.size.should == 1
      
        saved_skill.sub_embeddings_attributes = { 
            "0" => { _id: saved_skill.sub_embeddings.first._id, _destroy: '1' } }
        saved_skill.save!
      
        emptied_skill = Skill.find_by(title: "Skill A")
    
        emptied_skill.sub_embeddings.size.should == 0
        SkillEmbedding.count.should == 0
      end
    end
  end
  
  describe "ability points" do
    it "should aggregate ability points under subskills" do
      skill = Skill.create!(title: "Skill")
      skill_a = Skill.create!(title: "Sub Skill A")
      skill_b = Skill.create!(title: "Sub Skill B")  
      skill_aa = Skill.create!(title: "Sub Skill AA")
      skill_ab = Skill.create!(title: "Sub Skill AB")
      skill_ba = Skill.create!(title: "Sub Skill BA")
      skill_bb = Skill.create!(title: "Sub Skill BB")
      
      skill_embedding_a = build(:skill_embedding, sub_skill: skill_a, weight: 1)
      skill_embedding_b = build(:skill_embedding, sub_skill: skill_b, weight: 2)
      skill_embedding_aa = build(:skill_embedding, sub_skill: skill_aa, weight: 3)
      skill_embedding_ab = build(:skill_embedding, sub_skill: skill_ab, weight: 4)
      skill_embedding_ba = build(:skill_embedding, sub_skill: skill_ba, weight: 5)
      skill_embedding_bb = build(:skill_embedding, sub_skill: skill_bb, weight: 6)
      
      skill.sub_embeddings.concat([skill_embedding_a,skill_embedding_b])
      skill_a.sub_embeddings.concat([skill_embedding_aa,skill_embedding_ab])
      skill_b.sub_embeddings.concat([skill_embedding_ba,skill_embedding_bb])

      skill.ability_points["Skill"].should == 1
      skill.ability_points["Sub Skill A"].should == 1
      skill.ability_points["Sub Skill B"].should == 2
      skill.ability_points["Sub Skill AA"].should == 3
      skill.ability_points["Sub Skill AB"].should == 4
      skill.ability_points["Sub Skill BA"].should == 10
      skill.ability_points["Sub Skill BB"].should == 12
      
      skill_a.ability_points["Sub Skill A"].should == 1
      skill_a.ability_points["Sub Skill AA"].should == 3
      skill_a.ability_points["Sub Skill AB"].should == 4
      
      skill_b.ability_points["Sub Skill B"].should == 1
      skill_b.ability_points["Sub Skill BA"].should == 5
      skill_b.ability_points["Sub Skill BB"].should == 6
      
      skill_aa.ability_points["Sub Skill AA"].should == 1
      
      skill_ab.ability_points["Sub Skill AB"].should == 1
      
      skill_ba.ability_points["Sub Skill BA"].should == 1
      
      skill_bb.ability_points["Sub Skill BB"].should == 1
    end
    
    it "should calculate ability points when there are common subskills" do
      skill = Skill.create!(title: "Skill")
      skill_a = Skill.create!(title: "Sub Skill A")
      skill_b = Skill.create!(title: "Sub Skill B")  
      skill_c = Skill.create!(title: "Sub Skill C")
      
      skill_embedding_a = build(:skill_embedding, sub_skill: skill_a, weight: 1)
      skill_embedding_b = build(:skill_embedding, sub_skill: skill_b, weight: 2)
      skill_embedding_ac = build(:skill_embedding, sub_skill: skill_c, weight: 1)
      skill_embedding_bc = build(:skill_embedding, sub_skill: skill_c, weight: 2)
      
      skill.sub_embeddings.concat([skill_embedding_a,skill_embedding_b])
      skill_a.sub_embeddings << skill_embedding_ac
      skill_b.sub_embeddings << skill_embedding_bc
      
      skill.ability_points["Skill"].should == 1
      skill.ability_points["Sub Skill A"].should == 1
      skill.ability_points["Sub Skill B"].should == 2
      skill.ability_points["Sub Skill C"].should == 5
    end
  end
end