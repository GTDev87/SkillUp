class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  
  field :username
  attr_accessible :username
  validates_presence_of :username
  validates_uniqueness_of :username
  
  field :email
  attr_accessible :email
  validates_presence_of :email
  validates_uniqueness_of :email
  
  field :password_digest
  attr_accessible :password
  attr_accessible :password_confirmation
  has_secure_password
  
  embeds_many :user_abilities
  attr_accessible :user_abilities_attributes
  accepts_nested_attributes_for :user_abilities, :allow_destroy => true
  
  embeds_many :user_missions
  attr_accessible :user_missions_attributes
  accepts_nested_attributes_for :user_missions, :allow_destroy => true
  
  def ability_aptitude
    sum_over_mission_abilities(sum_over_abilities(Hash.new(0)))
  end
  
private
  def sum_over_abilities(aggregated_abilities)
    user_abilities.each_with_object(aggregated_abilities) { |user_ability, abilities| abilities[user_ability.ability.title] += user_ability.points}
  end
  
  def sum_over_mission_abilities(aggregated_abilities)
    user_missions.each_with_object(aggregated_abilities) { |user_mission, abilities_through| user_mission.mission.mission_abilities.each_with_object(abilities_through) { |mission_ability, abilities| abilities[mission_ability.ability.title] += mission_ability.points } }
  end
end