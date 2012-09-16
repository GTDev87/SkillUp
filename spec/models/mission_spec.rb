require 'spec_helper'

describe Mission do 
  it "should create Mission" do
    mission = Mission.new(:title => "A title", :description => "A description")
    
    mission.save.should be_true
  end
  
  describe "validation" do
    it "should require that Missions have titles" do
      mission = Mission.new(:description => "A description")
    
      mission.save.should be_false
    end
  end
  
  describe "relations" do
    it "should give multiple skill aptitudes to a mission" do
      mission = Mission.new(:title => "A title", :description => "A description")
      
      skill_aptitude1 = SkillAptitude.new(:skill => create(:skill))
      skill_aptitude2 = SkillAptitude.new(:skill => create(:skill))
      
      mission.skill_aptitudes << skill_aptitude1
      mission.skill_aptitudes << skill_aptitude2
      
      mission.save
      
      Mission.first.skill_aptitudes.size.should == 2
    end
  end
end