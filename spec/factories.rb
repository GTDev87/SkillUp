FactoryGirl.define do
  factory :mission do
    sequence(:title) { |n| "Mission Title #{n}" }
    sequence(:description) { |n| "Mission Description #{n}" }
    
    mission_skills []
  end

  factory :skill do
    sequence(:title) { |n| "Skill Title #{n}" }
    sequence(:description) { |n| "Skill Description #{n}" }
  end

  factory :user_skill do
    points 10
  end

  factory :user_mission do
  end

  factory :mission_skill do
    points 10
  end

  factory :user_connection do
  end

  factory :user_skill_rating do
    rating 5
  end

  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "foo#{n}@example.com" }
    admin false
    password "password"
    password_confirmation "password"
  end
  
  factory :skill_embedding do
    weight 10
  end
  
  factory :mission_embedding do
    count 10
  end
end