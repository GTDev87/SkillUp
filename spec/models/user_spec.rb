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
    
    it "should require that User have username" do
      user = User.new(password: "", password_confirmation: "")
    
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
    it "should give multiple user skill to a user" do
      user = User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
      
      user.user_skills << build(:user_skill, skill: create(:skill))
      user.user_skills << build(:user_skill, skill: create(:skill))
      
      User.first.user_skills.size.should == 2
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
  
  describe "calculating total ability aptitudes" do
    it "should aggregate ability points of skills over multiple tasks" do
      user = User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      running = create(:skill, title: "Running")
      
      running_mile = create(:mission, title: "Running Mile")
      running_mile.mission_skills << build(:mission_skill, skill: running, points: 8)
      
      sprinting = create(:mission, title: "Sprinting 100m")
      sprinting.mission_skills << build(:mission_skill, skill: running, points: 7)
      
      user.user_missions << build(:user_mission, mission: running_mile)
      user.user_missions << build(:user_mission, mission: sprinting)
      
      user.total_ability_points["Running"].should == 15
    end
    
    it "should aggregate values of skills over multiple tasks and inherent user skill" do
      user = User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      running = create(:skill, title: "Running")
      
      running_mile = create(:mission, title: "Running Mile")
      running_mile.mission_skills << build(:mission_skill, skill: running, points: 8)
      
      user.user_skills << build(:user_skill, skill: running, points: 10)
      
      user.user_missions << build(:user_mission, mission: running_mile)
      
      user.total_ability_points["Running"].should == 18
    end
    
    it "should aggregate multiple skills" do
      user = User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      running = create(:skill, title: "Running")
      cardio = create(:skill, title: "Cardio")
      
      running_mile = create(:mission, title: "Running Mile")
      running_mile.mission_skills << build(:mission_skill, skill: running, points: 8)
      running_mile.mission_skills << build(:mission_skill, skill: cardio, points: 20)
      
      sprinting = create(:mission, title: "Sprinting 100m")
      sprinting.mission_skills << build(:mission_skill, skill: running, points: 7)
      running_mile.mission_skills << build(:mission_skill, skill: cardio, points: 5)
      
      user.user_missions << build(:user_mission, mission: running_mile)
      user.user_missions << build(:user_mission, mission: sprinting)
      
      user.total_ability_points["Running"].should == 15
      user.total_ability_points["Cardio"].should == 25
    end
    
    it "should aggregate multiple abilities through sub skills" do
      user = User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      running_cardio_sub_embedding_points = 2
      
      running_mile_running_skill_points = 8
      running_mile_cardio_skill_points = 3
      
      cardio = create(:skill ,title: "Cardio")
      
      running = create(:skill, title: "Running")
      running.sub_embeddings << build(:skill_embedding, sub_skill: cardio, weight: running_cardio_sub_embedding_points)
      
      running_mile = create(:mission, title: "Running Mile")
      running_mile.mission_skills << build(:mission_skill, skill: running, points: running_mile_running_skill_points)
      running_mile.mission_skills << build(:mission_skill, skill: cardio, points: running_mile_cardio_skill_points)

      user.user_missions << build(:user_mission, mission: running_mile)
      
      user.total_ability_points["Running"].should == running_mile_running_skill_points
      user.total_ability_points["Cardio"].should == running_mile_running_skill_points * running_cardio_sub_embedding_points + running_mile_cardio_skill_points
    end
  end
  
  describe "skill only points" do
    it "should keep track of the points ignoring subskills" do
      user = User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      running_cardio_sub_embedding_points = 2
      
      running_skill_points = 8
      cardio_skill_points = 3
      
      cardio = create(:skill ,title: "Cardio")
      
      running = create(:skill, title: "Running")
      running.sub_embeddings << build(:skill_embedding, sub_skill: cardio, weight: running_cardio_sub_embedding_points)
      
      user.user_skills << build(:user_skill, skill: running, points: running_skill_points)
      user.user_skills << build(:user_skill, skill: cardio, points: cardio_skill_points)
      
      doesnt_matter = 12345
      
      running_mile = create(:mission, title: "Running Mile")
      running_mile.mission_skills << build(:mission_skill, skill: running, points: doesnt_matter)
      running_mile.mission_skills << build(:mission_skill, skill: cardio, points: doesnt_matter)

      user.user_missions << build(:user_mission, mission: running_mile)
      
      user.skill_only_points["Running"].should == running_skill_points
      user.skill_only_points["Cardio"].should == cardio_skill_points
    end
  end
  
  describe "ability only points" do
    it "should keep track of the points with subskill points ignoring missions" do
      user = User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      running_cardio_sub_embedding_points = 2
      
      running_skill_points = 8
      cardio_skill_points = 3
      
      cardio = create(:skill ,title: "Cardio")
      
      running = create(:skill, title: "Running")
      running.sub_embeddings << build(:skill_embedding, sub_skill: cardio, weight: running_cardio_sub_embedding_points)
      
      user.user_skills << build(:user_skill, skill: running, points: running_skill_points)
      user.user_skills << build(:user_skill, skill: cardio, points: cardio_skill_points)
      
      doesnt_matter = 12345
      
      running_mile = create(:mission, title: "Running Mile")
      running_mile.mission_skills << build(:mission_skill, skill: running, points: doesnt_matter)
      running_mile.mission_skills << build(:mission_skill, skill: cardio, points: doesnt_matter)

      user.user_missions << build(:user_mission, mission: running_mile)
      
      user.ability_only_points["Running"].should == running_skill_points
      user.ability_only_points["Cardio"].should == cardio_skill_points + running_skill_points * running_cardio_sub_embedding_points
    end
  end
  
  describe "mission only points" do
    it "should keep track of the points with missions and subskills ignoring user_ability" do
      user = User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      running_cardio_sub_embedding_points = 2
      
      running_skill_points = 8
      cardio_skill_points = 3
      
      cardio = create(:skill ,title: "Cardio")
      
      running = create(:skill, title: "Running")
      running.sub_embeddings << build(:skill_embedding, sub_skill: cardio, weight: running_cardio_sub_embedding_points)
      
      user.user_skills << build(:user_skill, skill: running, points: running_skill_points)
      user.user_skills << build(:user_skill, skill: cardio, points: cardio_skill_points)
      
      mission_skill_running = 1
      mission_skill_cardio = 2
      
      running_mile = create(:mission, title: "Running Mile")
      running_mile.mission_skills << build(:mission_skill, skill: running, points: mission_skill_running)
      running_mile.mission_skills << build(:mission_skill, skill: cardio, points: mission_skill_cardio)

      user.user_missions << build(:user_mission, mission: running_mile)
      
      user.mission_only_points["Running"].should == mission_skill_running
      user.mission_only_points["Cardio"].should == mission_skill_cardio + mission_skill_running * running_cardio_sub_embedding_points
    end
  end
  
  describe "fields" do
    it "should be able to assign email" do
      User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      User.first.email.should == "user@example.com"
    end
    
    it "should be able to assign username" do
      User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
      
      User.first.username.should == "username"
    end
    
    it "should be able to assign password and password confirmation" do
      User.create(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
      
      User.first.password_digest.should_not == nil
    end
    
    it "should be able to assign first_name" do
      User.create(first_name: "John", username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      User.first.first_name.should == "John"
    end
    
    it "should be able to assign email" do
      User.create(last_name: "Doe", username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      User.first.last_name.should == "Doe"
    end
    
    it "should be able to assign date_of_birth" do
      User.create(date_of_birth: "06/29/1988", username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      User.first.date_of_birth.should == "06/29/1988"
    end
    
    it "should be able to assign address" do
      User.create(address: "123 Evergreen Terrace", username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      User.first.address.should == "123 Evergreen Terrace"
    end
    
    it "should be able to assign email" do
      User.create(bio: "I'm Effing Great", username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
    
      User.first.bio.should == "I'm Effing Great"
    end
    
    it "should assign user_skills_attributes" do
      User.create!(
        username: "username", 
        email: "user@example.com", 
        password: "password", 
        password_confirmation: "password",
        user_skills_attributes: {
          "0" => {
            skill_title: "Skill A",
            points: 10 } } )
      
      User.first.user_skills.size.should == 1
      User.first.user_skills.first.skill.title.should == "Skill A"
      User.first.user_skills.first.points.should == 10
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
    describe UserSkill do
      it "should create a user_skills when it is given through nested attributes" do
        user = User.new(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
        
        user.user_skills_attributes = { 
          "0" => { skill_title: "Skill A", points: 10 },
          "1" => { skill_title: "Skill B", points: 11 } }
        user.save!
      
        saved_user = User.first
          
        saved_user.user_skills.size.should == 2
        saved_user.user_skills[0].skill.title.should == "Skill A"
        saved_user.user_skills[0].points.should == 10
        saved_user.user_skills[1].skill.title.should == "Skill B"
        saved_user.user_skills[1].points.should == 11
      end
    
      it "should delete using nested attributes" do
        user = User.new(username: "username", email: "user@example.com", password: "password", password_confirmation: "password")
      
        user.user_skills_attributes = { 
            "0" => { skill_title: "Skill A", points: 10 } }
        user.save!
      
        saved_user = User.first
        saved_user.user_skills.size.should == 1
      
        saved_user.user_skills_attributes = { 
            "0" => { _id: saved_user.user_skills.first._id, _destroy: '1' } }
        saved_user.save!
      
        emptied_user = User.first
      
        emptied_user.user_skills.size.should == 0
      end
    end
      
    describe UserMission do
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