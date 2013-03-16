class User < ActiveRecord::Base
  
  #field :admin, type: Boolean
  
  #login
  validates_presence_of :username
  validates_uniqueness_of :username
  
  validates_presence_of :email
  validates_uniqueness_of :email
  
  validates_presence_of :password, :on => :create
  has_secure_password
  
  #field :first_name
  #field :last_name
  #field :date_of_birth, :type => Date

  #test geocoding may want to be in a different process
  #field :address
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude, address: :address
  after_validation :geocode
  after_validation :reverse_geocode

  #field :bio

  mount_uploader :avatar, AvatarUploader
  


     

  #Points
  has_many :user_skills, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :user_skills, allow_destroy: true
  has_many :skills, through: :user_skills
  
  has_many :user_missions, dependent: :destroy, inverse_of: :user, order: "created_at DESC"
  accepts_nested_attributes_for :user_missions, allow_destroy: true
  has_many :missions, through: :user_missions

  #Moderator Status Needs Test
  has_many :user_mission_moderations, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :user_mission_moderations, allow_destroy: true
  #===========================
  has_many :user_skill_moderations, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :user_skill_moderations, allow_destroy: true
  ############################

  #friendships
  has_many :user_friendships, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :user_friendships, allow_destroy: true
  has_many :friends, through: :user_friendships
  has_many :inverse_user_friendships, class_name: "UserFriendship", foreign_key: "friend_id", dependent: :destroy, inverse_of: :friend
  
  #user ratings
  has_many :user_skill_ratings, dependent: :destroy, inverse_of: :rater, foreign_key: "rater_id", order: "created_at DESC"
  accepts_nested_attributes_for :user_skill_ratings, allow_destroy: true
  has_many :ratees, through: :user_skill_ratings
  has_many :inverse_user_skill_ratings, class_name: "UserSkillRating", foreign_key: "ratee_id", dependent: :destroy, inverse_of: :ratee
  
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