require 'spec_helper'

describe Task do 
  it "should create Task" do
    task = Task.new(:mission => create(:mission))
    user = User.new(:username => "username", :email => "user@email.com")
    
    user.tasks << task
    
    task.save.should be_true
  end
  
  describe "validations" do
    it "should have a mission" do
      task = Task.new
      user = User.new(:username => "username", :email => "user@email.com")
    
      user.tasks << task
    
      task.save.should be_false
    end
  end
end
