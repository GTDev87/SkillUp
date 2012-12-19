class UserConnection
  include Mongoid::Document

  #class need testing
  belongs_to :user, inverse_of: :user_connections
  validates_presence_of :user

  has_many :user_skill_ratings, inverse_of: :skill, autosave: true
  accepts_nested_attributes_for :user_skill_ratings, allow_destroy: true
end