class SkillPresenter < BasePresenter
  presents :skill
  
  def link
    link_to skill.title, skill_path(skill)
  end
end