require 'spec_helper'

describe Ability do 
  it "should create Ability" do
    ability = Ability.new(:title => "A title", :description => "A description")
    
    ability.save.should be_true
  end
  
  describe "validation" do
    it "should require that Ability have titles" do
      ability = Ability.new(:description => "A description")
    
      ability.save.should be_false
    end
  end
  
  describe "relations" do
    it "should be able to hold multiple skills" do
      ability = Ability.create(:title => "A title", :description => "A description")
      
      ability.skills << create(:skill)
      ability.skills << create(:skill)
      
      savedAbility = Ability.first
      
      savedAbility.skills.size.should == 2
    end
    
    it "should create an association through skill when ability gets skill" do
      ability = Ability.create(:title => "A title", :description => "A description")
      ability.skills << create(:skill)
      
      savedSkill = Skill.first
      
      savedSkill.abilities.size.should == 1
    end
  end
end
