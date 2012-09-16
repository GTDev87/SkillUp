require 'spec_helper'

describe User do 
  it "should create User" do
    user = User.new(:username => "username", :email => "user@example.com")
    
    user.save.should be_true
  end
  
  describe "validation" do
    it "should require that User have username" do
      user = User.new(:email => "user@example.com")
    
      user.save.should be_false
    end
    
    it "should require that User have email" do
      user = User.new(:username => "username")
    
      user.save.should be_false
    end
  end
  
  describe "relations" do
    it "should give multiple skill inherents to a user" do
      user = User.new(:username => "username", :email => "user@example.com")
      
      skill_inherent1 = SkillInherent.new(:skill => create(:skill))
      skill_inherent2 = SkillInherent.new(:skill => create(:skill))
      
      user.skill_inherents << skill_inherent1
      user.skill_inherents << skill_inherent2
      
      user.save
      
      User.first.skill_inherents.size.should == 2
    end
    
    it "should give multiple tasks to a user" do
      user = User.new(:username => "username", :email => "user@example.com")
      
      task1 = Task.new(:mission => create(:mission))
      task2 = Task.new(:mission => create(:mission))
      
      user.tasks << task2
      user.tasks << task2
      
      user.save
      
      User.first.tasks.size.should == 2
    end
  end
end