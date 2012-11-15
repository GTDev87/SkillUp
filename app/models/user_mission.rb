class UserMission
  include Mongoid::Document
 
  #attr_accessible :mission_title
  
  #EMBEDDED IN USER
  embedded_in :user, inverse_of: :user_missions
  validates_presence_of :user
  
  belongs_to :mission, inverse_of: nil
  validates_presence_of :mission
  
  def mission_title
    mission.try(:title)
  end

  def mission_title=(title)
    self.mission = Mission.find_or_create_by(title: title) if title.present?
  end
end
