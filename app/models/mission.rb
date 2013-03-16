class Mission < ActiveRecord::Base
  
  validates_presence_of :title
  #field :description, type: String

  has_many :user_missions, dependent: :destroy, inverse_of: :mission

  has_many :mission_skills, dependent: :destroy, inverse_of: :mission
  accepts_nested_attributes_for :mission_skills, allow_destroy: true
  validates :mission_skills, unique_mission_skill_reference: true
  has_many :skills, through: :mission_skills

  has_many :super_embeddings, class_name: "MissionEmbedding", foreign_key: "sub_mission_id", dependent: :destroy, inverse_of: :sub_mission
  has_many :super_mission, through: :super_embeddings, source: :mission

  has_many :mission_embeddings, dependent: :destroy, inverse_of: :super_mission, foreign_key: "super_mission_id"
  accepts_nested_attributes_for :mission_embeddings, allow_destroy: true
  validates :mission_embeddings, cyclical_sub_mission_reference: true, unique_sub_mission_reference: true
  has_many :sub_missions, through: :mission_embeddings

  has_many :user_mission_moderations, dependent: :destroy, inverse_of: :mission
  #Many of these methods desparately need preprocessing

  def total_ability_points
    HashOperations.add_hashes(ability_points, sub_mission_points_only)
  end
  
  def sub_mission_points_only
    mission_embeddings.inject(Hash.new(0)) do |agg_sub_missions, sub_embedding|
      multiplier = sub_embedding.count
      sub_mission_title = sub_embedding.sub_mission.title
      ability_points_multiplied = HashOperations.multiply_hash_by_value(Mission.find_by_title(sub_mission_title).total_ability_points, multiplier)
      HashOperations.add_hashes(agg_sub_missions, ability_points_multiplied)
    end
  end
  
  def ability_points
    skill_points.inject({}) do |agg_hash, (title, points_multiplier)|
      ability_points_multiplied = HashOperations.multiply_hash_by_value(Skill.find_by_title(title).ability_points, points_multiplier)
      HashOperations.add_hashes(agg_hash, ability_points_multiplied)
    end
  end

  def skill_levels
    HashOperations.hmap(total_ability_points) { |name, points| Skill.points_to_level(points) }
  end

  def associated_skill_names
    total_ability_points.map { |name, points| name }.to_set
  end
  
  def skill_points
    mission_skills.inject(Hash.new(0)) do |agg_skills, mission_skill| 
      agg_skills[mission_skill.skill.title] += mission_skill.points
      agg_skills
    end
  end
  
  def self.search_titles(mission_title_name)
    Mission.find(:all, :conditions => [ "title ILIKE ?", "%#{mission_title_name.downcase}%"])
  end
  
private
  def lower_title_case
    self.lowercase_title = self.title.downcase
  end
end
