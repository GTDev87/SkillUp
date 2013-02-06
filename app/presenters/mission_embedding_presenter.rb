class MissionEmbeddingPresenter < BasePresenter
  presents :mission_embedding
  
  delegate :count, to: :mission_embedding

  def link
  	sub_mission = mission_embedding.sub_mission
    link_to sub_mission.title, skill_path(sub_mission)
  end
end