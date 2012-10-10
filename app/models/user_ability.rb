class UserAbility
  include Mongoid::Document

  embedded_in :user, :inverse_of => :user_abilities
  
  field :points, type: Integer
  attr_accessible :points
  validates_presence_of :points
  
  belongs_to :ability, :inverse_of => nil
  validates_presence_of :ability
  
  attr_accessible :ability_title
  
  def ability_title
    ability.try(:title)
  end

  def ability_title=(title)
    self.ability = Ability.find_or_create_by(:title => title) if title.present?
  end
end
