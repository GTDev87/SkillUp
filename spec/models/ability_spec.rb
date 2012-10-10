require 'spec_helper'

describe Ability do 
  it "should create Ability" do
    ability = Ability.new(title: "A title", description: "A description")
    
    lambda {ability.save!}.should_not raise_error
  end
  
  it "should lower title's case after creation" do
    ability = Ability.create(title: "lOwErCaSe TiTlE", description: "A description")
    
    ability.lowercase_title.should == "lowercase title"
  end
  
  it "should search title by lowercase_title" do
    Ability.create(title: "case")
    Ability.create(title: "InCaSe")
    Ability.create(title: "cases")
    Ability.create(title: "UPPER CASE")
    Ability.create(title: "other word")
    
    Ability.search_titles("case").map{ |ability| ability.title }.should == ["case", "cases", "InCaSe", "UPPER CASE"]
  end
  
  describe "validation" do
    it "should require that Ability have titles" do
      ability = Ability.new(description: "A description")
    
      lambda {ability.save!}.should raise_error
    end
  end
  
  describe "mass assignment" do
    it "should be able to mass assign title" do
      Ability.create!(title: "Ability Title", description: "A description")
      
      Ability.first.title.should == "Ability Title"
    end
    
    it "should be able to mass assign description" do
      Ability.create!(title: "Ability Title", description: "A description")
      
      Ability.first.description.should == "A description"
    end
  end
  
  describe "relations" do
    it "should be able to hold multiple skills" do
      ability = Ability.create(title: "A title", description: "A description")
      
      ability.skills << create(:skill)
      ability.skills << create(:skill)
      
      savedAbility = Ability.first
      
      savedAbility.skills.size.should == 2
    end
    
    it "should create an association through skill when ability gets skill" do
      ability = Ability.create(title: "A title", description: "A description")
      ability.skills << create(:skill)
      
      savedSkill = Skill.first
      
      savedSkill.abilities.size.should == 1
    end
  end
end
