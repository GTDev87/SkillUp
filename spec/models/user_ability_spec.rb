require 'spec_helper'

describe UserAbility do 
  it "should create UserAbility" do
    user_ability = UserAbility.new(points: 10)
    user_ability.ability = create(:ability)
    
    create(:user).user_abilities << user_ability
    
    lambda {user_ability.save!}.should_not raise_error
  end
  
  describe "validations" do
    it "should have a ability" do
      user_ability = UserAbility.new(points: 10)
    
      create(:user).user_abilities << user_ability
    
      lambda {user_ability.save!}.should raise_error
    end
    
    it "should create UserAbility" do
      user_ability = UserAbility.new(ability: create(:ability))
      user_ability.ability = create(:ability)
    
      create(:user).user_abilities << user_ability
    
      lambda {user_ability.save!}.should raise_error
    end
  end
  
  describe "mass assignment" do
    it "should be able to mass assign level" do
      user_ability = UserAbility.new(points: 10)
      user_ability.ability = create(:ability, title: "Ability Title")
      create(:user).user_abilities << user_ability
      
      User.first.user_abilities.first.points.should == 10
    end
    
    it "should be able to mass assign ability_title" do
      user_ability = UserAbility.new(points: 10, ability_title: "Ability Title")
      create(:user).user_abilities << user_ability
      
      User.first.user_abilities.first.ability.title.should == "Ability Title"
    end
  end
  
  describe "virtual attributes" do
    describe  "should query ability by title" do
      it "should find nil if ability title does not exist" do
        user_ability = UserAbility.new(points: 10)
      
        user_ability.ability_title.should == nil
      end
    
      it "should find ability title if exists" do
        user_ability = UserAbility.new(points: 10)
      
        user_ability.ability = create(:ability, title: "Ability Name")
      
        user_ability.ability_title.should == "Ability Name"
      end
    
      it "find existing ability by title if exists" do
        user_ability = UserAbility.new(points: 10)
        
        create(:ability, title: "Existing Title")
        user_ability.ability_title = "Existing Title"
        
        Ability.count.should == 1
        Ability.first.title == "Existing Title"
      end
    
      it "should create ability if does not exist" do
        user_ability = UserAbility.new(points: 10)
        
        user_ability.ability_title = "Created Title"
        
        Ability.count.should == 1
        Ability.first.title == "Created Title"
      end
      
      it "should save ability to mission_ability when created" do
        user = create(:user)
        user_ability = UserAbility.new(points: 10)
        
        user.user_abilities << user_ability
        user_ability.ability_title = "Created Title"
        
        user.save!
        
        User.first.user_abilities[0].ability.title.should == "Created Title"
      end
    end
  end
end