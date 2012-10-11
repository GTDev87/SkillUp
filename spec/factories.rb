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

  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "foo#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end
end