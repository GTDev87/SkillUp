class MissionEmbedding
  include Mongoid::Document

  field :count, type: Integer
  validates_presence_of :count
  
  belongs_to :sub_mission, class_name: "Mission", inverse_of: :super_embeddings
  validates_presence_of :sub_mission
  
  belongs_to :super_mission, class_name: "Mission", inverse_of: :mission_embeddings
  validates_presence_of :super_mission
  
  def sub_mission_title
    sub_mission.try(:title)
  end

  def sub_mission_title=(title)
    self.sub_mission = Mission.find_by(title: title) if title.present?
  end
end
