require 'spec_helper'

describe UserSkillRating do 
  it "should create UserSkillRating" do
    user_skill_rating = UserSkillRating.new(rating: 0)
    create(:user).user_skill_ratings << user_skill_rating
    user_skill_rating.ratee = create(:user)
    user_skill_rating.skill = create(:skill)
    
    lambda {user_skill_rating.save!}.should_not raise_error
  end

  describe "fields" do
    it "should assign an integer rating" do
      user_skill_rating = UserSkillRating.new(rating: 10)
      create(:user).user_skill_ratings << user_skill_rating
      user_skill_rating.ratee = create(:user)
      user_skill_rating.skill = create(:skill)
    
      user_skill_rating.rating.should == 10
    end
  end

  describe "relations" do
    it "it should reference ratee and rater properly" do
      user_skill_rating = UserSkillRating.new(rating: 10)
      rater = create(:user)
      ratee = create(:user)
      rater.user_skill_ratings << user_skill_rating
      user_skill_rating.ratee = ratee
      user_skill_rating.skill = create(:skill)
    
      rater.user_skill_ratings.first.ratee.should == ratee
      ratee.inverse_user_skill_ratings.first.rater.should == rater
    end

    it "it should reference rater and skill properly" do
      user_skill_rating = UserSkillRating.new(rating: 10)
      rater = create(:user)
      skill = create(:skill)
      rater.user_skill_ratings << user_skill_rating
      user_skill_rating.ratee = create(:user)
      user_skill_rating.skill = skill
    
      rater.user_skill_ratings.first.skill.should == skill
      skill.user_skill_ratings.first.rater.should == rater
    end
  end
  
  describe "validations" do
    it "should have a ratee" do
      user_skill_rating = UserSkillRating.new(rating: 10)
      create(:user).user_skill_ratings << user_skill_rating
      user_skill_rating.skill = create(:skill)
    
      lambda {user_skill_rating.save!}.should raise_error
    end

    it "should have a skill" do
      user_skill_rating = UserSkillRating.new(rating: 10)
      create(:user).user_skill_ratings << user_skill_rating
      user_skill_rating.ratee = create(:user)
    
      lambda {user_skill_rating.save!}.should raise_error
    end

    it "should have a rating" do
      user_skill_rating = UserSkillRating.new
      create(:user).user_skill_ratings << user_skill_rating
      user_skill_rating.ratee = create(:user)
      user_skill_rating.skill = create(:skill)
    
      lambda {user_skill_rating.save!}.should raise_error
    end
  end
end