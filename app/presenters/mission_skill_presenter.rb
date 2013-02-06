class MissionSkillPresenter < BasePresenter
  presents :mission_skill

  delegate :points, to: :mission_skill
  
  def link
    skill = mission_skill.skill
    link_to skill.title, skill_path(skill)
  end
end