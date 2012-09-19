class MissionAbility
  include Mongoid::Document
  
  embedded_in :mission, :inverse_of => :mission_abilities
  
  field :level, type: Integer
  
  has_one :ability
  validates_presence_of :ability
end
