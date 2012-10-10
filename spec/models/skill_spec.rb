require 'spec_helper'

describe Skill do
  it "should create Skill" do
    skill = Skill.new(title: "A title", description: "A description")
    
    lambda {skill.save!}.should_not raise_error
  end
  
  describe "validation" do
    it "should require that Skills have titles" do
      skill = Skill.new(description: "A description")
    
      lambda {skill.save!}.should raise_error
    end
  end
  
  describe "relations" do
    it "should be able to hold multiple skills" do
      skill = Skill.create(title: "A title", description: "A description")
      
      skill.abilities << create(:ability)
      skill.abilities << create(:ability)
      
      savedSkill = Skill.first
      
      savedSkill.abilities.size.should == 2
    end
    
    it "should create an association through ability when skill gets ability" do
      skill = Skill.create(title: "A title", description: "A description")
      skill.abilities << create(:ability)
      
      savedAbility = Ability.first
      
      savedAbility.skills.size.should == 1
    end
  end
end