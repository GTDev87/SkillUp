class SkillInherent
  include Mongoid::Document

  embedded_in :user, :inverse_of => :skill_inherents
  
  field :level, type: Integer
  
  has_one :skill
  validates_presence_of :skill
end
