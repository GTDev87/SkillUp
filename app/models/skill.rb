class Skill
  include Mongoid::Document
  
  belongs_to :skill_inherent, :inverse_of => :skill
  belongs_to :skill_aptitude, :inverse_of => :skill
  
  field :title, type: String
  validates_presence_of :title
  
  field :description, type: String
  
  has_and_belongs_to_many :abilities
end
