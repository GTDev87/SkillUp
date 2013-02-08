class UserSkillModeration
  include Mongoid::Document
  
  belongs_to :user, inverse_of: :user_skill_moderations
  validates_presence_of :user
  
  belongs_to :skill, inverse_of: :user_skill_moderations
  validates_presence_of :skill
end