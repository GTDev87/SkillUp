require 'spec_helper'

describe Skill do 
  it "should create Skill" do
    skill = Skill.new(:title => "A title", :description => "A description")
    
    skill.save.should be_true
  end
  
  describe "validation" do
    it "should require that Skill have titles" do
      skill = Skill.new(:description => "A description")
    
      skill.save.should be_false
    end
  end
  
  describe "relations" do
    it "should be able to hold multiple abilities" do
      skill = Skill.create(:title => "A title", :description => "A description")
      
      skill.abilities << create(:ability)
      skill.abilities << create(:ability)
      
      savedSkill = Skill.first
      
      savedSkill.abilities.size.should == 2
    end
    
    it "should create an association through ability when skill gets ability" do
      skill = Skill.create(:title => "A title", :description => "A description")
      skill.abilities << create(:ability)
      
      savedAbility = Ability.first
      
      savedAbility.skills.size.should == 1
    end
  end
end
