class UserMission
  include Mongoid::Document
 
  embedded_in :user, :inverse_of => :user_missions
  
  has_one :mission
  validates_presence_of :mission
end
