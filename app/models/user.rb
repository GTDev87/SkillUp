class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  include Mongoid::MultiParameterAttributes
  include Mongoid::Timestamps
  
  field :admin, type: Boolean
  
  #login
  field :username
  validates_presence_of :username
  validates_uniqueness_of :username
  
  field :email
  validates_presence_of :email
  validates_uniqueness_of :email
  
  field :password_digest
  validates_presence_of :password, :on => :create
  has_secure_password
  
  field :first_name
  field :last_name
  field :date_of_birth, :type => Date

  field :address
  
  field :bio

  mount_uploader :avatar, AvatarUploader
  
  #Points
  has_many :user_skills, autosave: true
  accepts_nested_attributes_for :user_skills, allow_destroy: true
  
  has_many :user_missions, autosave: true
  accepts_nested_attributes_for :user_missions, allow_destroy: true
  
  has_many :user_connections, autosave: true
  accepts_nested_attributes_for :user_connections, allow_destroy: true

  has_many :inverse_user_connections, class_name: "UserConnection", inverse_of: :connection

  has_many :user_skill_ratings, inverse_of: :rater, autosave: true
  accepts_nested_attributes_for :user_skill_ratings, allow_destroy: true

  has_many :inverse_user_skill_ratings, class_name: "UserSkillRating", inverse_of: :ratee

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