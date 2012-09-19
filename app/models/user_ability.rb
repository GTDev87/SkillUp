class UserAbility
  include Mongoid::Document

  embedded_in :user, :inverse_of => :user_abilities
  
  field :level, type: Integer
  
  has_one :ability
  validates_presence_of :ability
end
