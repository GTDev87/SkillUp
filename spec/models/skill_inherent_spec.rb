require 'spec_helper'

describe SkillInherent do 
  it "should create SkillInherent" do
    skill_inherent = SkillInherent.new(:level => 10, :skill => create(:skill))
    user = User.new(:username => "username", :email => "user@email.com")
    
    user.skill_inherents << skill_inherent
    
    skill_inherent.save.should be_true
  end
  
  describe "validations" do
    it "should have a skill" do
      skill_inherent = SkillInherent.new(:level => 10)
      user = User.new(:username => "username", :email => "user@email.com")
    
      user.skill_inherents << skill_inherent
    
      skill_inherent.save.should be_false
    end
  end
end