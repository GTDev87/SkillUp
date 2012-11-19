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
  
  def ability_points
    sub_embeddings.inject({ self.title => 1 }) do |aggregate_hash, embedding|
      modified_embedding = HashOperations.multiply_hash_by_value(embedding.sub_skill.ability_points, embedding.weight)
      HashOperations.add_hashes(aggregate_hash, modified_embedding)
    end
  end
  
  def self.search_titles(skill_title_name)
    Skill.any_of({lowercase_title: /.*#{skill_title_name.downcase}.*/ }).sort(lowercase_title: 1).entries
  end
  
private
  def lower_title_case
    self.lowercase_title = self.title.downcase
  end  
end
