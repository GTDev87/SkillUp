class SkillEmbedding < ActiveRecord::Base
 
  validates_presence_of :weight
  
  belongs_to :sub_skill, class_name: "Skill", inverse_of: :super_embeddings
  validates_presence_of :sub_skill
  
  belongs_to :super_skill, class_name: "Skill", inverse_of: :skill_embeddings
  validates_presence_of :super_skill
  
  def sub_skill_title
    sub_skill.try(:title)
  end

  def sub_skill_title=(title)
    self.sub_skill = Skill.find_by_title(title) if title.present?
  end
end
