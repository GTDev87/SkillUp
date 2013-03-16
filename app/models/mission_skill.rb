class MissionSkill < ActiveRecord::Base
  
  #Many to many REFERENCED IN MISSION AND SKILL
  belongs_to :mission, inverse_of: :mission_skills
  validates_presence_of :mission
  
  belongs_to :skill, inverse_of: :mission_skills
  validates_presence_of :skill
  
  validates_presence_of :points

  def skill_title
    skill.try(:title)
  end

  def skill_title=(title)
    self.skill = Skill.find_by_title(title) if title.present?
  end
end
