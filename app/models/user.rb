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
  
  embeds_many :user_skills
  attr_accessible :user_skills_attributes
  accepts_nested_attributes_for :user_skills, allow_destroy: true
  
  embeds_many :user_missions
  attr_accessible :user_missions_attributes
  accepts_nested_attributes_for :user_missions, allow_destroy: true
  
  def ability_aptitude
    sum_over_mission_skills(sum_over_skills(Hash.new(0)))
  end
  
private
  def sum_over_skills(aggregated_skills)
    user_skills.each_with_object(aggregated_skills) do |user_skill, skills| 
      skills[user_skill.skill.title] += user_skill.points
    end
  end
  
  def sum_over_mission_skills(aggregated_skills)
    user_missions.inject(aggregated_skills) do |skills_through, user_mission|
      skills_through.merge(user_mission.mission.ability_points) do |key, agg_val, skill_val|
        agg_val + skill_val
      end
    end
  end
end