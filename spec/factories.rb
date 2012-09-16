FactoryGirl.define do
  factory :ability do
    sequence(:title) { |n| "Ability Title #{n}" }
    sequence(:description) { |n| "Ability Description #{n}" }
  end

  factory :mission do
    sequence(:title) { |n| "Mission Title #{n}" }
    sequence(:description) { |n| "Mission Description #{n}" }
    
    skill_aptitudes []
  end

  factory :skill do
    sequence(:title) { |n| "Skill Title #{n}" }
    sequence(:description) { |n| "Skill Description #{n}" }
  end

  factory :skill_aptitude do
    level 10
  end

  factory :skill_inherent do
    level 10
  end

  factory :task do
  end

  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "foo#{n}@example.com" }
  end
end