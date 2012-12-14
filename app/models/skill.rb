class Skill
  include Mongoid::Document 

  field :title, type: String
  validates_presence_of :title
  
  field :lowercase_title
  before_create :lower_title_case
  
  field :description, type: String
  
  has_many :mission_skills, inverse_of: :skill

  has_many :super_embeddings, class_name: "SkillEmbedding", inverse_of: :sub_skill
  
  has_many :sub_embeddings, class_name: "SkillEmbedding", inverse_of: :super_skill, autosave: true
  accepts_nested_attributes_for :sub_embeddings, allow_destroy: true
  validates :sub_embeddings, cyclical_sub_skill_reference: true, unique_sub_skill_reference: true
  
  def self.points_to_level(points)
    self.default_level_maxs.each_with_index.map { |max, i| points >= max ? i + 1: nil }.compact.unshift(0).last
  end

  def self.default_level_maxs
    [1, 5, 10, 20, 50, 150, 500, 2000, 10000, 50000]
  end

  def ability_points
    sub_embeddings.inject({ self.title => 1 }) do |aggregate_hash, embedding|
      modified_embedding = HashOperations.multiply_hash_by_value(embedding.sub_skill.ability_points, embedding.weight)
      HashOperations.add_hashes(aggregate_hash, modified_embedding)
    end
  end

  def all_ancestor_skills
    super_embeddings.inject(Set.new([self])) { |aggregate_set, embedding | aggregate_set | embedding.super_skill.all_ancestor_skills | [embedding.super_skill].to_set }
  end

  def associated_missions
    all_ancestor_skills.map { |skill| skill.mission_skills.map { |mission_skill| mission_skill.mission.title } }.flatten.to_set
  end
  
  def self.search_titles(skill_title_name)
    Skill.any_of({lowercase_title: /.*#{skill_title_name.downcase}.*/ }).sort(lowercase_title: 1).entries
  end
  
private
  def lower_title_case
    self.lowercase_title = self.title.downcase
  end  
end
