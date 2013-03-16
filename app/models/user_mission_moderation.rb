class UserMissionModeration < ActiveRecord::Base

  belongs_to :user, inverse_of: :user_mission_moderations
  validates_presence_of :user
  
  belongs_to :mission, inverse_of: :user_mission_moderations
  validates_presence_of :mission
end