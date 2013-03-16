require 'spec_helper'

describe UserSkill do 
  it "should create UserSkill" do
    user_skill = UserSkill.new(points: 10)
    user_skill.skill = create(:skill)
    
    create(:user).user_skills << user_skill
    
    lambda {user_skill.save!}.should_not raise_error
  end
  
  describe "validations" do
    it "should have a skill" do
      user_skill = UserSkill.new(points: 10)
    
      create(:user).user_skills << user_skill
    
      lambda {user_skill.save!}.should raise_error
    end
    
    it "should create UserSkill" do
      user_skill = UserSkill.new(skill: create(:skill))
      user_skill.skill = create(:skill)
    
      create(:user).user_skills << user_skill
    
      lambda {user_skill.save!}.should raise_error
    end
  end
  
  describe "fields" do
    it "should be able to assign level" do
      user_skill = UserSkill.new(points: 10)
      user_skill.skill = create(:skill, title: "Skill Title")
      create(:user).user_skills << user_skill
      
      User.first.user_skills.first.points.should == 10
    end
    
    it "should be able to assign skill_title" do
      create(:skill, title: "Skill Title")
      user_skill = UserSkill.new(points: 10, skill_title: "Skill Title")
      create(:user).user_skills << user_skill
      
      User.first.user_skills.first.skill.title.should == "Skill Title"
    end
  end
  
  describe "virtual attributes" do
    describe  "should query skill by title" do
      it "should find nil if skill title does not exist" do
        user_skill = UserSkill.new(points: 10)
      
        user_skill.skill.should == nil
      end
    
      it "should find ability title if exists" do
        user_skill = UserSkill.new(points: 10)
      
        user_skill.skill = create(:skill, title: "Skill Name")
      
        user_skill.skill_title.should == "Skill Name"
      end
    
      it "find existing skill by title if exists" do
        user_skill = UserSkill.new(points: 10)
        
        create(:skill, title: "Existing Title")
        user_skill.skill_title = "Existing Title"
        
        Skill.count.should == 1
        Skill.first.title == "Existing Title"
      end
      
      it "should fail when skill does not exist" do
        user = create(:user)
        user_skill = UserSkill.new(points: 10)
        
        user.user_skills << user_skill
        
        user_skill.skill_title = "Created Title"
        user_skill.skill_title.should be_nil
      end
    end
  end
end