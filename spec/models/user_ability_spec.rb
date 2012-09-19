require 'spec_helper'

describe UserAbility do 
  it "should create UserAbility" do
    user_ability = UserAbility.new(:level => 10, :ability => create(:ability))
    user = User.new(:username => "username", :email => "user@email.com")
    
    user.user_abilities << user_ability
    
    user_ability.save.should be_true
  end
  
  describe "validations" do
    it "should have a ability" do
      user_ability = UserAbility.new(:level => 10)
      user = User.new(:username => "username", :email => "user@email.com")
    
      user.user_abilities << user_ability
    
      user_ability.save.should be_false
    end
  end
end