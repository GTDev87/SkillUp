class Skill < ActiveRecord::Base

  validates_presence_of :title
  
  #field :description, type: String



  #needs test
  has_many :user_skills, dependent: :destroy, inverse_of: :skill
  
  has_many :mission_skills, dependent: :destroy, inverse_of: :skill

  has_many :super_embeddings, class_name: "SkillEmbedding", foreign_key: "sub_skill_id", dependent: :destroy, inverse_of: :sub_skill
  has_many :super_skill, through: :super_embeddings, source: :skill

  has_many :user_skill_ratings, dependent: :destroy, inverse_of: :skill
  
  has_many :skill_embeddings, dependent: :destroy, inverse_of: :super_skill, foreign_key: "super_skill_id"
  accepts_nested_attributes_for :skill_embeddings, allow_destroy: true
  validates :skill_embeddings, cyclical_sub_skill_reference: true, unique_sub_skill_reference: true
  has_many :sub_skills, through: :skill_embeddings


     #needs test
  #has_many :friendships
  #has_many :friends, :through => :friendships
  #has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  #has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  #models/friendship.rb
  #belongs_to :user
  #belongs_to :friend, :class_name => "User

  has_many :user_skill_moderations, autosave: true
  
  #Many of these methods desparately need preprocessing

  def self.points_to_level(points)
    self.default_level_maxs.each_with_index.map { |max, i| points >= max ? i + 1: nil }.compact.unshift(0).last
  end

  def self.default_level_maxs
    [1, 5, 10, 20, 50, 150, 500, 2000, 10000, 50000]
  end

  def ability_points
    skill_embeddings.inject({ self.title => 1 }) do |aggregate_hash, embedding|
      modified_embedding = HashOperations.multiply_hash_by_value(embedding.sub_skill.ability_points, embedding.weight)
      HashOperations.add_hashes(aggregate_hash, modified_embedding)
    end
  end

  def all_ancestor_skills
    super_embeddings.inject(Set.new([self])) { |aggregate_set, embedding | aggregate_set | embedding.super_skill.all_ancestor_skills | [embedding.super_skill].to_set }
  end

  def associated_missions
    all_ancestor_skills.map { |skill| skill.mission_skills.map { |mission_skill| mission_skill.mission } }.flatten.to_set
  end

  def all_missions_at_level(level)
    associated_missions.find_all { |mission| self.class.points_to_level(mission.total_ability_points[title]) == level }.to_set
  end
  
  def self.search_titles(skill_title_name)
    Skill.find(:all, :conditions => [ "title ILIKE ?", "%#{skill_title_name.downcase}%"])
  end
  
private
  def lower_title_case
    self.lowercase_title = self.title.downcase
  end  
end
