FactoryGirl.define do
  factory :ability do
    sequence(:title) { |n| "Ability Title #{n}" }
    sequence(:description) { |n| "Ability Description #{n}" }
  end

  factory :mission do
    sequence(:title) { |n| "Mission Title #{n}" }
    sequence(:description) { |n| "Mission Description #{n}" }
    
    mission_abilities []
  end

  factory :skill do
    sequence(:title) { |n| "Skill Title #{n}" }
    sequence(:description) { |n| "Skill Description #{n}" }
  end

  factory :user_ability do
    level 10
  end

  factory :user_mission do
    level 10
  end

  factory :mission_ability do
  end

  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "foo#{n}@example.com" }
  end
end