class Mission
  include Mongoid::Document

  belongs_to :user_mission, :inverse_of => :mission

  field :title, type: String
  validates_presence_of :title
  
  field :description, type: String
  
  embeds_many :mission_abilities
end
