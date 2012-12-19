class UserSkillRating
  include Mongoid::Document
  
  field :rating, type: Integer
  validates_presence_of :rating

  belongs_to :rater, class_name: "User", inverse_of: :user_skill_ratings
  validates_presence_of :rater

  belongs_to :ratee, class_name: "User", inverse_of: :inverse_user_skill_ratings
  validates_presence_of :ratee

  belongs_to :skill, inverse_of: :user_skill_ratings, autosave: true
  validates_presence_of :skill
end