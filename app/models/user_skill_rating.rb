class UserSkillRating
  include Mongoid::Document
  
  field :rating, type: Integer

  #class need testing
  belongs_to :user_connection, inverse_of: :user_skill_ratings
  validates_presence_of :user_connection

  belongs_to :skill, inverse_of: :user_skill_ratings, autosave: true
  validates_presence_of :skill
end