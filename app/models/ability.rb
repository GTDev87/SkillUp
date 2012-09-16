class Ability
  include Mongoid::Document
  
  field :title, type: String
  validates_presence_of :title
  
  field :description, type: String
  
  has_and_belongs_to_many :skills
end
