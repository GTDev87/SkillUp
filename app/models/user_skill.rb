class UserSkill
  include Mongoid::Document

  #EMBEDDED IN USER
  embedded_in :user, inverse_of: :user_skills
  validates_presence_of :user
  
  field :points, type: Integer
  attr_accessible :points
  validates_presence_of :points
  
  belongs_to :skill, inverse_of: nil
  validates_presence_of :skill
  
  attr_accessible :skill_title
  
  def skill_title
    skill.try(:title)
  end

  def skill_title=(title)
    self.skill = Skill.find_or_create_by(title: title) if title.present?
  end
end
