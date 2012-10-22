class Mission
  include Mongoid::Document

  attr_accessible :title
  field :title, type: String
  validates_presence_of :title
  
  field :lowercase_title
  before_create :lower_title_case
  
  attr_accessible :description
  field :description, type: String
  
  has_many :mission_skills, inverse_of: :mission, autosave: true
  accepts_nested_attributes_for :mission_skills, allow_destroy: true
  attr_accessible :mission_skills_attributes
  
  #UNTESTED RANGE
  #has_many :super_embeddings, class_name: "MissionEmbedding", inverse_of: :sub_mission
  
  #has_many :sub_embeddings, class_name: "MissionEmbedding", inverse_of: :super_mission, autosave: true
  #accepts_nested_attributes_for :sub_embeddings, allow_destroy: true
  #validates :sub_embeddings, :cyclical_reference => true
  #attr_accessible :sub_embeddings_attributes
  #UNTESTED DONE
  
  def ability_points
    skill_points.inject({}) do |agg_hash, (title, points_multiplier)|
      ability_points_multiplied = HashOperations.multiply_hash_by_value(Skill.find_by(title: title).ability_points, points_multiplier)
      HashOperations.add_hashes(agg_hash, ability_points_multiplied)
    end
  end
  
  def skill_points
    mission_skills.inject(Hash.new(0)) do |agg_skills, mission_skill| 
      agg_skills[mission_skill.skill.title] += mission_skill.points
      agg_skills
    end
  end
  
  def self.search_titles(mission_title_name)
    Mission.any_of({lowercase_title: /.*#{mission_title_name.downcase}.*/ }).sort(lowercase_title: 1).entries  
  end
  
private
  def lower_title_case
    self.lowercase_title = self.title.downcase
  end
end
