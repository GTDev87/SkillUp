class UserMissionPresenter < BasePresenter
  presents :user_mission
  
  def mission
    mission = user_mission.mission
    link_to mission.title, mission_path(mission)
  end
end