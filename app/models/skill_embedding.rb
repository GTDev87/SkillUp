class SkillEmbedding
  include Mongoid::Document

  attr_accessible :weight
  field :weight, type: Integer
  validates_presence_of :weight
  
  belongs_to :sub_skill, class_name: "Skill", inverse_of: :super_embeddings
  validates_presence_of :sub_skill
  
  belongs_to :super_skill, class_name: "Skill", inverse_of: :sub_embeddings
  validates_presence_of :super_skill
  
  attr_accessible :sub_skill_title
  
  def sub_skill_title
    sub_skill.try(:title)
  end

  def sub_skill_title=(title)
    self.sub_skill = Skill.find_by(title: title) if title.present?
  end
end
