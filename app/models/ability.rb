class Ability
  include Mongoid::Document
  
  belongs_to :user_ability, :inverse_of => :ability
  belongs_to :mission_ability, :inverse_of => :ability
  
  field :title, type: String
  validates_presence_of :title
  
  field :description, type: String
  
  has_and_belongs_to_many :skills
end
