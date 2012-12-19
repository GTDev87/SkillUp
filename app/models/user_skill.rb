class UserSkill
  include Mongoid::Document

  #EMBEDDED IN USER
  belongs_to :user, inverse_of: :user_skills
  validates_presence_of :user
  
  field :points, type: Integer
  validates_presence_of :points
  
  belongs_to :skill, inverse_of: :user_skills
  validates_presence_of :skill
  
  def skill_title
    skill.try(:title)
  end

  def skill_title=(title)
    self.skill = Skill.find_by(title: title) if title.present?
  end
end
