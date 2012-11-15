class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  
  #attr_accessible :username, :email, :password, :password_confirmation, :user_skills_attributes, :user_missions_attributes
  
  field :admin, type: Boolean
  
  field :username
  validates_presence_of :username
  validates_uniqueness_of :username
  
  field :email
  validates_presence_of :email
  validates_uniqueness_of :email
  
  field :password_digest
  has_secure_password
  
  embeds_many :user_skills
  accepts_nested_attributes_for :user_skills, allow_destroy: true
  
  embeds_many :user_missions
  accepts_nested_attributes_for :user_missions, allow_destroy: true
  
  def total_ability_points
    HashOperations.add_hashes(mission_only_points, ability_only_points)
  end
  
  def skill_only_points
    user_skills.inject(Hash.new(0)) do |skills_agg, user_skill| 
      skills_agg[user_skill.skill.title] += user_skill.points
      skills_agg
    end
  end
  
  def ability_only_points
    user_skills.inject(Hash.new(0)) do |skills_agg, user_skill|
      mod_user_skill_points = HashOperations.multiply_hash_by_value(user_skill.skill.ability_points, user_skill.points)
      HashOperations.add_hashes(skills_agg, mod_user_skill_points)
    end
  end
  
  def mission_only_points
    user_missions.inject(Hash.new(0)) do |skills_agg, user_mission|
      HashOperations.add_hashes(skills_agg, user_mission.mission.ability_points)
    end
  end 
end