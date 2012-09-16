class SkillAptitude
  include Mongoid::Document
  
  embedded_in :mission, :inverse_of => :skill_aptitude
  
  field :level, type: Integer
  
  has_one :skill
  validates_presence_of :skill
end
