class UserMissionPresenter < BasePresenter
  presents :user_mission
  #class needs testing
  def mission
    mission = user_mission.mission
    link_to mission.title, mission_path(mission)
  end
end