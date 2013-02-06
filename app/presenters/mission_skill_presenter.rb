class MissionSkillPresenter < BasePresenter
  presents :mission_skill

  delegate :points, to: :mission_skill
  #class needs testing
  def link
    skill = mission_skill.skill
    link_to skill.title, skill_path(skill)
  end
end