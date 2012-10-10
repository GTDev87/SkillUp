require 'spec_helper'

describe User do 
  it "should create User" do
    user = User.new(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
    lambda {user.save!}.should_not raise_error
  end
  
  describe "validation" do
    it "should require that User have username" do
      user = User.new(email: "user@example.com", password: "password", password_confirmation: "password")
    
      lambda {user.save!}.should raise_error
    end
    
    it "should require username uniqueness" do
      User.create(username: "username",email: "user@example.com", password: "password", password_confirmation: "password")
      user = User.new(username: "username",email: "otherUser@example.com", password: "password", password_confirmation: "password")
    
      lambda {user.save!}.should raise_error
    end
    
    it "should require that User have email" do
      user = User.new(username: "username", password: "password", password_confirmation: "password")
    
      lambda {user.save!}.should raise_error
    end
    
    it "should require email uniqueness" do
      User.create(username: "username",email: "user@example.com", password: "password", password_confirmation: "password")
      user = User.new(username: "otherUsername",email: "user@example.com", password: "password", password_confirmation: "password")
    
      lambda {user.save!}.should raise_error
    end
  end
  
  describe "relations" do
    it "should give multiple user ability to a user" do
      user = User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
      
      user.user_abilities << build(:user_ability, ability: create(:ability))
      user.user_abilities << build(:user_ability, ability: create(:ability))
      
      User.first.user_abilities.size.should == 2
    end
    
    it "should give multiple user mission to a user" do
      user = User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
      
      user.user_missions << build(:user_mission, mission: create(:mission))
      user.user_missions << build(:user_mission, mission: create(:mission))
      
      User.first.user_missions.size.should == 2
    end
  end
  
  describe "password authentication" do
    it "should require password and confirmation matching" do
      user = User.new(username: "username", email: "user@example.com", password: "password", password_confirmation: "not password")
    
      lambda {user.save!}.should raise_error
    end
  end
  
  describe "calculating ability aptitudes" do
    it "should aggregate values of abilities over multiple tasks" do
      user = User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      running = create(:ability, title: "Running")
      
      running_mile = create(:mission, title: "Running Mile")
      running_mile.mission_abilities << build(:mission_ability, ability: running, points: 8)
      
      sprinting = create(:mission, title: "Sprinting 100m")
      sprinting.mission_abilities << build(:mission_ability, ability: running, points: 7)
      
      user.user_missions << build(:user_mission, mission: running_mile)
      user.user_missions << build(:user_mission, mission: sprinting)
      
      user.ability_aptitude["Running"].should == 15
    end
    
    it "should aggregate values of abilities over multiple tasks and inherent user ability" do
      user = User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      running = create(:ability, title: "Running")
      
      running_mile = create(:mission, title: "Running Mile")
      running_mile.mission_abilities << build(:mission_ability, ability: running, points: 8)
      
      user.user_abilities << build(:user_ability, ability: running, points: 10)
      
      user.user_missions << build(:user_mission, mission: running_mile)
      
      user.ability_aptitude["Running"].should == 18
    end
    
    it "should aggregate multiple abilities" do
      user = User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      running = create(:ability, title: "Running")
      cardio = create(:ability, title: "Cardio")
      
      running_mile = create(:mission, title: "Running Mile")
      running_mile.mission_abilities << build(:mission_ability, ability: running, points: 8)
      running_mile.mission_abilities << build(:mission_ability, ability: cardio, points: 20)
      
      sprinting = create(:mission, title: "Sprinting 100m")
      sprinting.mission_abilities << build(:mission_ability, ability: running, points: 7)
      running_mile.mission_abilities << build(:mission_ability, ability: cardio, points: 5)
      
      user.user_missions << build(:user_mission, mission: running_mile)
      user.user_missions << build(:user_mission, mission: sprinting)
      
      user.ability_aptitude["Running"].should == 15
      user.ability_aptitude["Cardio"].should == 25
    end
  end
  
  describe "mass assignment" do
    it "should be able to mass assign email" do
      User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      User.first.email.should == "user@example.com"
    end
    
    it "should be able to mass assign username" do
      User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
      
      User.first.username.should == "username"
    end
    
    it "should be able to mass assign password and password confirmation" do
      User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
      
      User.first.password_digest.should_not == nil
    end
    
    it "should assign user_abilities_attributes" do
      User.create!(
        username: "username", 
        email: "user@example.com", 
        password: "password", 
        password_confirmation: "password",
        user_abilities_attributes: {
          "0" => {
            ability_title: "Ability A",
            points: 10 } } )
      
      User.first.user_abilities.size.should == 1
      User.first.user_abilities.first.ability.title.should == "Ability A"
      User.first.user_abilities.first.points.should == 10
    end
    
    it "should assign user_missions_attributes" do
      User.create!(
        username: "username", 
        email: "user@example.com", 
        password: "password", 
        password_confirmation: "password",
        user_missions_attributes: {
          "0" => {
            mission_title: "Mission A"} } )
      
      User.first.user_missions.size.should == 1
      User.first.user_missions.first.mission.title.should == "Mission A"
    end
  end
  
  describe "nested attributes" do
    describe "user_abilities" do
      it "should create a user_abilities when it is given through nested attributes" do
        user = User.new(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
        
        user.user_abilities_attributes = { 
          "0" => { ability_title: "Ability A", points: 10 },
          "1" => { ability_title: "Ability B", points: 11 } }
        user.save!
      
        saved_user = User.first
          
        saved_user.user_abilities.size.should == 2
        saved_user.user_abilities[0].ability.title.should == "Ability A"
        saved_user.user_abilities[0].points.should == 10
        saved_user.user_abilities[1].ability.title.should == "Ability B"
        saved_user.user_abilities[1].points.should == 11
      end
    
      it "should delete using nested attributes" do
        user = User.new(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
      
        user.user_abilities_attributes = { 
            "0" => { ability_title: "Ability A", points: 10 } }
        user.save!
      
        saved_user = User.first
        saved_user.user_abilities.size.should == 1
      
        saved_user.user_abilities_attributes = { 
            "0" => { _id: saved_user.user_abilities.first._id, _destroy: '1' } }
        saved_user.save!
      
        emptied_user = User.first
      
        emptied_user.user_abilities.size.should == 0
      end
    end
      
    describe "user_missions" do
      it "should create a user_mission when it is given through nested attributes" do
        user = User.new(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
        
        user.user_missions_attributes = { 
            "0" => { mission_title: "Mission A" },
            "1" => { mission_title: "Mission B" } }
        user.save!
      
        saved_user = User.first
          
        saved_user.user_missions.size.should == 2
        saved_user.user_missions[0].mission.title.should == "Mission A"
        saved_user.user_missions[1].mission.title.should == "Mission B"
      end
    
      it "should delete using nested attributes" do
        user = User.new(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
      
        user.user_missions_attributes = { 
            "0" => { mission_title: "Mission A" } }
        user.save!
      
        saved_user = User.first
        saved_user.user_missions.size.should == 1
      
        saved_user.user_missions_attributes = { 
            "0" => { _id: saved_user.user_missions.first._id, _destroy: '1' } }
        saved_user.save!
      
        emptied_user = User.first
      
        emptied_user.user_missions.size.should == 0
      end
    end
  end
end