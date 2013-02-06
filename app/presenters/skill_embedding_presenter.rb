class SkillEmbeddingPresenter < BasePresenter
  presents :skill_embedding
  
  delegate :weight, to: :skill_embedding

  def link
  	sub_skill = skill_embedding.sub_skill
    link_to sub_skill.title, skill_path(sub_skill)
  end
end