require 'spec_helper'

describe SkillEmbedding do 
  it "should create SkillEmbedding" do
    skill_embedding = SkillEmbedding.new(weight: 10)
    skill_embedding.sub_skill = create(:skill)
    skill_embedding.super_skill = create(:skill)
     
    lambda {skill_embedding.save!}.should_not raise_error
  end
  
  describe "validations" do
    it "should have a sub skill" do
      skill_embedding = SkillEmbedding.new(weight: 10)
      skill_embedding.super_skill = create(:skill)
     
      lambda {skill_embedding.save!}.should raise_error
    end
    
    it "should have a super skill" do
      skill_embedding = SkillEmbedding.new(weight: 10)
      skill_embedding.sub_skill = create(:skill)
     
      lambda {skill_embedding.save!}.should raise_error
    end
    
    it "should have weight" do
      skill_embedding = SkillEmbedding.new
      skill_embedding.sub_skill = create(:skill)
      skill_embedding.super_skill = create(:skill)
     
      lambda {skill_embedding.save!}.should raise_error
    end
  end
  
  describe "relations" do
    describe Skill do
      it "should reference Skill" do
        skill_embedding = SkillEmbedding.new(weight: 10)
        
        sub_skill = create(:skill, title: "Sub Skill Title")
        skill_embedding.sub_skill = sub_skill
        super_skill = create(:skill, title: "Super Skill Title")
        skill_embedding.super_skill = super_skill
        skill_embedding.save!
        
        SkillEmbedding.find(skill_embedding._id).sub_skill.title.should == "Sub Skill Title"
        SkillEmbedding.find(skill_embedding._id).super_skill.title.should == "Super Skill Title"
      end
      
      it "should be referenced by Skill" do
        skill_embedding = SkillEmbedding.new(weight: 10)
        
        sub_skill = create(:skill, title: "Sub Skill Title")
        skill_embedding.sub_skill = sub_skill
        super_skill = create(:skill, title: "Super Skill Title")
        skill_embedding.super_skill = super_skill
        skill_embedding.save!
        
        Skill.find(sub_skill._id).super_embeddings.first.weight.should == 10
        Skill.find(super_skill._id).skill_embeddings.first.weight.should == 10
      end
    end
  end
  
  describe "fields" do
    it "should be able to assign points" do
      skill_embedding = SkillEmbedding.new(weight: 10)
      skill_embedding.sub_skill = create(:skill)
      skill_embedding.super_skill = create(:skill)
      skill_embedding.save!
      
      skill_embedding.weight.should == 10
    end
    
    it "should be able to assign sub_skill_title" do
      create(:skill, title: "Sub Skill Title") 
      skill_embedding = SkillEmbedding.new(weight: 10, sub_skill_title: "Sub Skill Title")
      skill_embedding.super_skill = create(:skill)
      skill_embedding.save!
      
      skill_embedding.sub_skill.title.should == "Sub Skill Title"
    end
  end
  
  describe "virtual attributes" do
    describe  "should query skill by title" do
      it "should find nil if skill title does not exist" do
        skill_embedding = SkillEmbedding.new(weight: 10)
      
        skill_embedding.sub_skill_title.should == nil
      end
    
      it "should find skill title if exists" do
        skill_embedding = SkillEmbedding.new(weight: 10)
      
        skill_embedding.super_skill = create(:skill)
        skill_embedding.sub_skill = create(:skill, title: "Sub Skill Title")
      
        skill_embedding.sub_skill_title.should == "Sub Skill Title"
      end
    
      it "find existing skill by title if exists" do
        skill_embedding = SkillEmbedding.new(weight: 10)
        
        create(:skill, title: "Sub Skill Title", description: "Description")
        
        skill_embedding.sub_skill_title = "Sub Skill Title"
        
        Skill.count.should == 1
        Skill.find_by(title: "Sub Skill Title").title == "Sub Skill Title"
      end
      
      it "should save skill to mission_skill when created" do
        skill_embedding = SkillEmbedding.new(weight: 10)
        skill_embedding.super_skill = create(:skill)
      
        create(:skill, title: "Sub Skill Title", description: "Description")
      
        skill_embedding.sub_skill_title = "Sub Skill Title"
        skill_embedding.save!
      
        skill_embedding.sub_skill.title.should == "Sub Skill Title"
        skill_embedding.sub_skill.description.should == "Description"
      end
    end
  end
end