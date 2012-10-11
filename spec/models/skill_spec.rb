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
    it "should require that Ability have titles" do
      skill = Skill.new(description: "A description")
    
      lambda {skill.save!}.should raise_error
    end
  end
  
  describe "mass assignment" do
    it "should be able to mass assign title" do
      Skill.create!(title: "Ability Title", description: "A description")
      
      Skill.first.title.should == "Ability Title"
    end
    
    it "should be able to mass assign description" do
      Skill.create!(title: "Ability Title", description: "A description")
      
      Skill.first.description.should == "A description"
    end
  end
end