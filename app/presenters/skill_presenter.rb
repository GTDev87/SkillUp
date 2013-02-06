class SkillPresenter < BasePresenter
  presents :skill
  #class needs testing
  def link
    link_to skill.title, skill_path(skill)
  end
end