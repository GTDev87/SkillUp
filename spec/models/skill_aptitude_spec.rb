require 'spec_helper'

describe SkillAptitude do 
  it "should create SkillAptitude" do
    skill_aptitude = SkillAptitude.new(:level => 10, :skill => create(:skill))
    mission = Mission.new(:title => "Mission Title")
    
    mission.skill_aptitudes << skill_aptitude
    
    skill_aptitude.save.should be_true
  end
  
  describe "validations" do
    it "should have a skill" do
      skill_aptitude = SkillAptitude.new(:level => 10)
      mission = Mission.new(:title => "Mission Title")
    
      mission.skill_aptitudes << skill_aptitude
    
      skill_aptitude.save.should be_false
    end
  end
end