class MissionSkill
  include Mongoid::Document
  
  embedded_in :mission, :inverse_of => :mission_skills
  
  attr_accessible :points
  field :points, type: Integer
  validates_presence_of :points
  
  belongs_to :skill, :inverse_of => nil
  validates_presence_of :skill
  
  attr_accessible :skill_title
  
  def skill_title
    skill.try(:title)
  end

  def skill_title=(title)
    self.skill = Skill.find_or_create_by(:title => title) if title.present?
  end
end
